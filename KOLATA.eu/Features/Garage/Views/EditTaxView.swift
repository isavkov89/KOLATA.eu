import SwiftUI

struct EditTaxView: View {
    let car: Car
    let tax: TaxEntry?
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var amount: String
    @State private var dueDate: Date
    @State private var status: String
    @State private var notes: String

    private let statusOptions = ["Pending", "Paid", "Overdue"]
    private var isEditing: Bool { tax != nil }

    init(car: Car, tax: TaxEntry?) {
        self.car = car
        self.tax = tax
        _title = State(initialValue: tax?.title ?? "")
        _amount = State(initialValue: tax.map { String($0.amount) } ?? "")
        _dueDate = State(initialValue: tax?.dueDate ?? Date())
        _status = State(initialValue: tax?.status ?? "Pending")
        _notes = State(initialValue: tax?.notes ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Amount (BGN)", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    Picker("Status", selection: $status) {
                        ForEach(statusOptions, id: \.self) { Text($0) }
                    }
                }

                Section("Notes") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
            }
            .navigationTitle(isEditing ? "Edit Tax" : "Add Tax")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func save() {
        if let tax {
            tax.title = title
            tax.amount = Double(amount) ?? 0
            tax.dueDate = dueDate
            tax.status = status
            tax.notes = notes
        } else {
            let newTax = TaxEntry(
                title: title,
                amount: Double(amount) ?? 0,
                dueDate: dueDate,
                status: status,
                notes: notes
            )
            car.taxes.append(newTax)
        }
        dismiss()
    }
}

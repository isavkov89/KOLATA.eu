import SwiftUI

struct EditRepairView: View {
    let car: Car
    let repair: RepairEntry?
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var entryDescription: String
    @State private var date: Date
    @State private var cost: String
    @State private var serviceProvider: String
    @State private var notes: String

    private var isEditing: Bool { repair != nil }

    init(car: Car, repair: RepairEntry?) {
        self.car = car
        self.repair = repair
        _title = State(initialValue: repair?.title ?? "")
        _entryDescription = State(initialValue: repair?.entryDescription ?? "")
        _date = State(initialValue: repair?.date ?? Date())
        _cost = State(initialValue: repair.map { String($0.cost) } ?? "")
        _serviceProvider = State(initialValue: repair?.serviceProvider ?? "")
        _notes = State(initialValue: repair?.notes ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $entryDescription, axis: .vertical)
                        .lineLimit(2...4)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section("Cost") {
                    TextField("Cost (BGN)", text: $cost)
                        .keyboardType(.decimalPad)
                    TextField("Service Provider", text: $serviceProvider)
                }

                Section("Notes") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
            }
            .navigationTitle(isEditing ? "Edit Repair" : "Add Repair")
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
        if let repair {
            repair.title = title
            repair.entryDescription = entryDescription
            repair.date = date
            repair.cost = Double(cost) ?? 0
            repair.serviceProvider = serviceProvider
            repair.notes = notes
        } else {
            let entry = RepairEntry(
                title: title,
                entryDescription: entryDescription,
                date: date,
                cost: Double(cost) ?? 0,
                serviceProvider: serviceProvider,
                notes: notes
            )
            car.repairs.append(entry)
        }
        dismiss()
    }
}

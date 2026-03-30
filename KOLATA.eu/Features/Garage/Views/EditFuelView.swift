import SwiftUI

struct EditFuelView: View {
    let car: Car
    let entry: FuelEntry?
    @Environment(\.dismiss) private var dismiss

    @State private var date: Date
    @State private var liters: String
    @State private var totalCost: String
    @State private var pricePerLiter: String
    @State private var odometer: String
    @State private var notes: String

    private var isEditing: Bool { entry != nil }

    init(car: Car, entry: FuelEntry?) {
        self.car = car
        self.entry = entry
        _date = State(initialValue: entry?.date ?? Date())
        _liters = State(initialValue: entry.map { String($0.liters) } ?? "")
        _totalCost = State(initialValue: entry.map { String($0.totalCost) } ?? "")
        _pricePerLiter = State(initialValue: entry.map { String($0.pricePerLiter) } ?? "")
        _odometer = State(initialValue: entry.map { String($0.odometer) } ?? "")
        _notes = State(initialValue: entry?.notes ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Liters", text: $liters)
                        .keyboardType(.decimalPad)
                    TextField("Total Cost (BGN)", text: $totalCost)
                        .keyboardType(.decimalPad)
                    TextField("Price per Liter", text: $pricePerLiter)
                        .keyboardType(.decimalPad)
                    TextField("Odometer (km)", text: $odometer)
                        .keyboardType(.numberPad)
                }

                Section("Notes") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
            }
            .navigationTitle(isEditing ? "Edit Fuel Entry" : "Add Fuel Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                }
            }
        }
    }

    private func save() {
        if let entry {
            entry.date = date
            entry.liters = Double(liters) ?? 0
            entry.totalCost = Double(totalCost) ?? 0
            entry.pricePerLiter = Double(pricePerLiter) ?? 0
            entry.odometer = Int(odometer) ?? 0
            entry.notes = notes
        } else {
            let newEntry = FuelEntry(
                date: date,
                liters: Double(liters) ?? 0,
                totalCost: Double(totalCost) ?? 0,
                pricePerLiter: Double(pricePerLiter) ?? 0,
                odometer: Int(odometer) ?? 0,
                notes: notes
            )
            car.fuelEntries.append(newEntry)
        }
        dismiss()
    }
}

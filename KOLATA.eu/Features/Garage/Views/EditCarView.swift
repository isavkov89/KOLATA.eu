import SwiftUI

struct EditCarView: View {
    let car: Car
    @Environment(\.dismiss) private var dismiss

    @State private var brand: String
    @State private var model: String
    @State private var year: Int
    @State private var registrationNumber: String
    @State private var vin: String
    @State private var fuelType: String
    @State private var mileage: String
    @State private var color: String
    @State private var notes: String

    private let fuelTypes = ["Gasoline", "Diesel", "LPG", "Electric", "Hybrid", "CNG"]

    init(car: Car) {
        self.car = car
        _brand = State(initialValue: car.brand)
        _model = State(initialValue: car.model)
        _year = State(initialValue: car.year)
        _registrationNumber = State(initialValue: car.registrationNumber)
        _vin = State(initialValue: car.vin)
        _fuelType = State(initialValue: car.fuelType)
        _mileage = State(initialValue: String(car.mileage))
        _color = State(initialValue: car.color)
        _notes = State(initialValue: car.notes)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Info") {
                    TextField("Brand", text: $brand)
                    TextField("Model", text: $model)
                    Picker("Year", selection: $year) {
                        ForEach((1970...Calendar.current.component(.year, from: Date())).reversed(), id: \.self) { y in
                            Text(String(y)).tag(y)
                        }
                    }
                    TextField("Registration Number", text: $registrationNumber)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                }

                Section("Details") {
                    TextField("VIN", text: $vin)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                    Picker("Fuel Type", selection: $fuelType) {
                        ForEach(fuelTypes, id: \.self) { Text($0) }
                    }
                    TextField("Mileage (km)", text: $mileage)
                        .keyboardType(.numberPad)
                    TextField("Color", text: $color)
                }

                Section("Notes") {
                    TextField("Additional notes", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Edit Car")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveChanges() }
                }
            }
        }
    }

    private func saveChanges() {
        car.brand = brand
        car.model = model
        car.year = year
        car.registrationNumber = registrationNumber
        car.vin = vin
        car.fuelType = fuelType
        car.mileage = Int(mileage) ?? car.mileage
        car.color = color
        car.notes = notes
        dismiss()
    }
}

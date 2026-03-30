import SwiftUI
import SwiftData

struct AddCarView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var brand = ""
    @State private var model = ""
    @State private var year = Calendar.current.component(.year, from: Date())
    @State private var registrationNumber = ""
    @State private var vin = ""
    @State private var fuelType = "Gasoline"
    @State private var mileage = ""
    @State private var color = ""
    @State private var notes = ""

    private let fuelTypes = ["Gasoline", "Diesel", "LPG", "Electric", "Hybrid", "CNG"]

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
            .navigationTitle("Add Car")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveCar() }
                        .disabled(brand.isEmpty || model.isEmpty)
                }
            }
        }
    }

    private func saveCar() {
        let car = Car(
            brand: brand,
            model: model,
            year: year,
            registrationNumber: registrationNumber,
            vin: vin,
            fuelType: fuelType,
            mileage: Int(mileage) ?? 0,
            color: color,
            notes: notes
        )

        // Initialize status entries
        for type in StatusType.allCases {
            let status = CarStatus(type: type)
            car.statuses.append(status)
        }

        modelContext.insert(car)
        try? modelContext.save()
        dismiss()
    }
}

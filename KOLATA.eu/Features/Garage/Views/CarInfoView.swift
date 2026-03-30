import SwiftUI

struct CarInfoView: View {
    let car: Car

    var body: some View {
        List {
            Section("Vehicle") {
                InfoRow(label: "Brand", value: car.brand, icon: "car")
                InfoRow(label: "Model", value: car.model, icon: "car.2")
                InfoRow(label: "Year", value: String(car.year), icon: "calendar")
                InfoRow(label: "Color", value: car.color.isEmpty ? "—" : car.color, icon: "paintpalette")
            }

            Section("Registration") {
                InfoRow(label: "Reg. Number", value: car.registrationNumber.isEmpty ? "—" : car.registrationNumber, icon: "number")
                InfoRow(label: "VIN", value: car.vin.isEmpty ? "—" : car.vin, icon: "barcode")
            }

            Section("Technical") {
                InfoRow(label: "Fuel Type", value: car.fuelType, icon: "fuelpump")
                InfoRow(label: "Mileage", value: "\(car.mileage) km", icon: "gauge.with.needle")
            }

            if !car.notes.isEmpty {
                Section("Notes") {
                    Text(car.notes)
                        .font(.body)
                }
            }
        }
        .navigationTitle("General Info")
    }
}

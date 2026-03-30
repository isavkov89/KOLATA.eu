import Foundation
import SwiftData

@Model
final class Car {
    var id: UUID
    var brand: String
    var model: String
    var year: Int
    var registrationNumber: String
    var vin: String
    var fuelType: String
    var mileage: Int
    var color: String
    var notes: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade) var repairs: [RepairEntry]
    @Relationship(deleteRule: .cascade) var fuelEntries: [FuelEntry]
    @Relationship(deleteRule: .cascade) var events: [EventEntry]
    @Relationship(deleteRule: .cascade) var taxes: [TaxEntry]
    @Relationship(deleteRule: .cascade) var documents: [DocumentEntry]
    @Relationship(deleteRule: .cascade) var statuses: [CarStatus]

    init(brand: String = "", model: String = "", year: Int = Calendar.current.component(.year, from: Date()), registrationNumber: String = "", vin: String = "", fuelType: String = "Gasoline", mileage: Int = 0, color: String = "", notes: String = "") {
        self.id = UUID()
        self.brand = brand
        self.model = model
        self.year = year
        self.registrationNumber = registrationNumber
        self.vin = vin
        self.fuelType = fuelType
        self.mileage = mileage
        self.color = color
        self.notes = notes
        self.createdAt = Date()
        self.repairs = []
        self.fuelEntries = []
        self.events = []
        self.taxes = []
        self.documents = []
        self.statuses = []
    }

    var displayName: String {
        if brand.isEmpty && model.isEmpty {
            return "My Car"
        }
        return "\(brand) \(model)".trimmingCharacters(in: .whitespaces)
    }
}

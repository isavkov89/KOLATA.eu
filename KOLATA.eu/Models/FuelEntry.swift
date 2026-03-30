import Foundation
import SwiftData

@Model
final class FuelEntry {
    var id: UUID
    var date: Date
    var liters: Double
    var totalCost: Double
    var pricePerLiter: Double
    var odometer: Int
    var notes: String
    var car: Car?

    init(date: Date = Date(), liters: Double = 0, totalCost: Double = 0, pricePerLiter: Double = 0, odometer: Int = 0, notes: String = "") {
        self.id = UUID()
        self.date = date
        self.liters = liters
        self.totalCost = totalCost
        self.pricePerLiter = pricePerLiter
        self.odometer = odometer
        self.notes = notes
    }
}

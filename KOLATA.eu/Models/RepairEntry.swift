import Foundation
import SwiftData

@Model
final class RepairEntry {
    var id: UUID
    var title: String
    var entryDescription: String
    var date: Date
    var cost: Double
    var serviceProvider: String
    var notes: String
    var car: Car?

    init(title: String = "", entryDescription: String = "", date: Date = Date(), cost: Double = 0, serviceProvider: String = "", notes: String = "") {
        self.id = UUID()
        self.title = title
        self.entryDescription = entryDescription
        self.date = date
        self.cost = cost
        self.serviceProvider = serviceProvider
        self.notes = notes
    }
}

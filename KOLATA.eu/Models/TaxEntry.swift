import Foundation
import SwiftData

@Model
final class TaxEntry {
    var id: UUID
    var title: String
    var amount: Double
    var dueDate: Date
    var status: String
    var notes: String
    var car: Car?

    init(title: String = "", amount: Double = 0, dueDate: Date = Date(), status: String = "Pending", notes: String = "") {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.dueDate = dueDate
        self.status = status
        self.notes = notes
    }
}

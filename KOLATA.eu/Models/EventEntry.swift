import Foundation
import SwiftData

@Model
final class EventEntry {
    var id: UUID
    var title: String
    var type: String
    var date: Date
    var entryDescription: String
    var notes: String
    var car: Car?

    init(title: String = "", type: String = "General", date: Date = Date(), entryDescription: String = "", notes: String = "") {
        self.id = UUID()
        self.title = title
        self.type = type
        self.date = date
        self.entryDescription = entryDescription
        self.notes = notes
    }
}

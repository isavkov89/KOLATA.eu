import Foundation
import SwiftData

enum DocumentCategory: String, Codable, CaseIterable {
    case registrationDocument = "Registration Document"
    case liabilityInsurance = "Liability Insurance"
    case casco = "Casco"
    case technicalInspection = "Technical Inspection"
    case vignette = "Vignette"
    case serviceDocument = "Service Document"
    case invoiceReceipt = "Invoice / Receipt"
    case taxes = "Taxes"
    case other = "Other"

    var icon: String {
        switch self {
        case .registrationDocument: return "doc.text"
        case .liabilityInsurance: return "shield"
        case .casco: return "car.circle"
        case .technicalInspection: return "wrench.and.screwdriver"
        case .vignette: return "road.lanes"
        case .serviceDocument: return "doc.badge.gearshape"
        case .invoiceReceipt: return "receipt"
        case .taxes: return "banknote"
        case .other: return "folder"
        }
    }
}

@Model
final class DocumentEntry {
    var id: UUID
    var title: String
    var category: DocumentCategory
    var uploadDate: Date
    var fileURL: String
    var notes: String
    var car: Car?

    init(title: String = "", category: DocumentCategory = .other, uploadDate: Date = Date(), fileURL: String = "", notes: String = "") {
        self.id = UUID()
        self.title = title
        self.category = category
        self.uploadDate = uploadDate
        self.fileURL = fileURL
        self.notes = notes
    }
}

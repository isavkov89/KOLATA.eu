import Foundation
import SwiftData

enum StatusType: String, Codable, CaseIterable {
    case vignette = "Vignette"
    case technicalInspection = "Technical Inspection"
    case liabilityInsurance = "Liability Insurance"

    var icon: String {
        switch self {
        case .vignette: return "road.lanes"
        case .technicalInspection: return "wrench.and.screwdriver"
        case .liabilityInsurance: return "shield.checkered"
        }
    }
}

enum ValidityStatus: String, Codable {
    case valid = "Valid"
    case expiringSoon = "Expiring Soon"
    case expired = "Expired"
    case unknown = "Unknown"

    var color: String {
        switch self {
        case .valid: return "statusGreen"
        case .expiringSoon: return "statusOrange"
        case .expired: return "statusRed"
        case .unknown: return "statusGray"
        }
    }
}

@Model
final class CarStatus {
    var id: UUID
    var type: StatusType
    var status: ValidityStatus
    var expirationDate: Date?
    var lastCheckedDate: Date?
    var source: String
    var car: Car?

    init(type: StatusType, status: ValidityStatus = .unknown, expirationDate: Date? = nil, lastCheckedDate: Date? = nil, source: String = "Manual") {
        self.id = UUID()
        self.type = type
        self.status = status
        self.expirationDate = expirationDate
        self.lastCheckedDate = lastCheckedDate
        self.source = source
    }

    var computedStatus: ValidityStatus {
        guard let expDate = expirationDate else { return .unknown }
        let now = Date()
        if expDate < now { return .expired }
        let daysUntilExpiry = Calendar.current.dateComponents([.day], from: now, to: expDate).day ?? 0
        if daysUntilExpiry <= 30 { return .expiringSoon }
        return .valid
    }
}

import Foundation
import SwiftData

@Model
final class User {
    var id: UUID
    var name: String
    var email: String
    var preferredLanguage: String
    var notificationsEnabled: Bool
    var biometricUnlockEnabled: Bool
    var createdAt: Date

    init(name: String = "", email: String = "", preferredLanguage: String = "en", notificationsEnabled: Bool = true, biometricUnlockEnabled: Bool = false) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.preferredLanguage = preferredLanguage
        self.notificationsEnabled = notificationsEnabled
        self.biometricUnlockEnabled = biometricUnlockEnabled
        self.createdAt = Date()
    }
}

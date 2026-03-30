import SwiftUI

struct NotificationSettingsView: View {
    @Environment(AuthManager.self) private var authManager

    @State private var pushNotifications = true
    @State private var expirationReminders = true
    @State private var taxReminders = true
    @State private var serviceReminders = true

    var body: some View {
        Form {
            Section("General") {
                Toggle("Push Notifications", isOn: $pushNotifications)
            }

            Section("Reminders") {
                Toggle("Expiration Reminders", isOn: $expirationReminders)
                Toggle("Tax Due Reminders", isOn: $taxReminders)
                Toggle("Service Reminders", isOn: $serviceReminders)
            }

            Section {
                Text("Notification settings will be fully functional in a future update.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Notifications")
        .onChange(of: pushNotifications) { _, newValue in
            authManager.currentUser?.notificationsEnabled = newValue
        }
    }
}

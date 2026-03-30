import SwiftUI
import SwiftData

@main
struct KOLATA_euApp: App {
    @State private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
        }
        .modelContainer(for: [
            User.self,
            Car.self,
            CarStatus.self,
            RepairEntry.self,
            FuelEntry.self,
            EventEntry.self,
            TaxEntry.self,
            DocumentEntry.self
        ])
    }
}

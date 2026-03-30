import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            authManager.configure(with: modelContext)
        }
    }
}

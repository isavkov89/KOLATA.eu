import Foundation
import SwiftData
import SwiftUI

@Observable
final class AuthManager {
    var isAuthenticated = false
    var isLoading = false
    var currentUser: User?
    var errorMessage: String?

    private var modelContext: ModelContext?

    func configure(with modelContext: ModelContext) {
        self.modelContext = modelContext
        loadUser()
    }

    private func loadUser() {
        guard let modelContext else { return }
        let descriptor = FetchDescriptor<User>()
        if let user = try? modelContext.fetch(descriptor).first {
            currentUser = user
            isAuthenticated = true
        }
    }

    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        // Simulate network delay
        try? await Task.sleep(for: .milliseconds(800))

        guard let modelContext else {
            errorMessage = "System error"
            isLoading = false
            return
        }

        // For MVP, check if user exists locally
        let descriptor = FetchDescriptor<User>()
        if let user = try? modelContext.fetch(descriptor).first, user.email == email {
            currentUser = user
            isAuthenticated = true
        } else {
            errorMessage = "Invalid email or password"
        }
        isLoading = false
    }

    func register(name: String, email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        // Simulate network delay
        try? await Task.sleep(for: .milliseconds(800))

        guard let modelContext else {
            errorMessage = "System error"
            isLoading = false
            return
        }

        // Check if user already exists
        let descriptor = FetchDescriptor<User>()
        if let existing = try? modelContext.fetch(descriptor).first, existing.email == email {
            errorMessage = "An account with this email already exists"
            isLoading = false
            return
        }

        let user = User(name: name, email: email)
        modelContext.insert(user)
        try? modelContext.save()

        currentUser = user
        isAuthenticated = true
        isLoading = false
    }

    func resetPassword(email: String) async -> Bool {
        isLoading = true
        errorMessage = nil

        try? await Task.sleep(for: .milliseconds(800))

        // For MVP, just simulate success
        isLoading = false
        return true
    }

    func logout() {
        isAuthenticated = false
        currentUser = nil
    }

    func deleteAccount() {
        guard let modelContext, let user = currentUser else { return }
        modelContext.delete(user)
        try? modelContext.save()
        logout()
    }

    func updateProfile(name: String, email: String) {
        guard let user = currentUser else { return }
        user.name = name
        user.email = email
        try? modelContext?.save()
    }
}

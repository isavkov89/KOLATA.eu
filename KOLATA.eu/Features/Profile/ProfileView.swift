import SwiftUI

struct ProfileView: View {
    @Environment(AuthManager.self) private var authManager
    @State private var showEditProfile = false
    @State private var showChangePassword = false
    @State private var showLogoutConfirmation = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                // Profile header
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.tint)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(authManager.currentUser?.name ?? "User")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(authManager.currentUser?.email ?? "")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .listRowBackground(Color.clear)
                }

                Section("Profile") {
                    Button {
                        showEditProfile = true
                    } label: {
                        Label("Edit Profile", systemImage: "person")
                    }
                    Button {
                        showChangePassword = true
                    } label: {
                        Label("Change Password", systemImage: "lock")
                    }
                }

                Section("App Settings") {
                    NavigationLink {
                        NotificationSettingsView()
                    } label: {
                        Label("Notifications", systemImage: "bell")
                    }
                    NavigationLink {
                        LanguageSettingsView()
                    } label: {
                        Label("Language", systemImage: "globe")
                    }
                    Label("Biometric Unlock", systemImage: "faceid")
                        .badge("Coming Soon")
                }

                Section("Help & Legal") {
                    NavigationLink {
                        FAQView()
                    } label: {
                        Label("FAQ", systemImage: "questionmark.circle")
                    }
                    NavigationLink {
                        PlaceholderLegalView(title: "Privacy Policy")
                    } label: {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                    NavigationLink {
                        PlaceholderLegalView(title: "Terms of Service")
                    } label: {
                        Label("Terms of Service", systemImage: "doc.plaintext")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showLogoutConfirmation = true
                    } label: {
                        Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                    }

                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete Account", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
            }
            .sheet(isPresented: $showChangePassword) {
                ChangePasswordView()
            }
            .alert("Log Out?", isPresented: $showLogoutConfirmation) {
                Button("Log Out", role: .destructive) {
                    authManager.logout()
                }
                Button("Cancel", role: .cancel) {}
            }
            .alert("Delete Account?", isPresented: $showDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    authManager.deleteAccount()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will permanently delete your account and all associated data.")
            }
        }
    }
}

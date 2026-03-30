import SwiftUI

struct EditProfileView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var email: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        authManager.updateProfile(name: name, email: email)
                        dismiss()
                    }
                    .disabled(name.isEmpty || email.isEmpty)
                }
            }
            .onAppear {
                name = authManager.currentUser?.name ?? ""
                email = authManager.currentUser?.email ?? ""
            }
        }
    }
}

import SwiftUI

struct LanguageSettingsView: View {
    @Environment(AuthManager.self) private var authManager
    @State private var selectedLanguage = "en"

    private let languages = [
        ("en", "English"),
        ("bg", "Български")
    ]

    var body: some View {
        Form {
            Section("Language") {
                ForEach(languages, id: \.0) { code, name in
                    Button {
                        selectedLanguage = code
                        authManager.currentUser?.preferredLanguage = code
                    } label: {
                        HStack {
                            Text(name)
                                .foregroundStyle(.primary)
                            Spacer()
                            if selectedLanguage == code {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.tint)
                            }
                        }
                    }
                }
            }

            Section {
                Text("Full localization support will be available in a future update.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Language")
        .onAppear {
            selectedLanguage = authManager.currentUser?.preferredLanguage ?? "en"
        }
    }
}

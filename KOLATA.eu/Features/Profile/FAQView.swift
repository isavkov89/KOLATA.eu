import SwiftUI

struct FAQView: View {
    private let faqs: [(String, String)] = [
        ("How do I add my car?", "Go to the Garage tab and tap the + button to add your car details."),
        ("How do I check my vignette status?", "In the Garage tab, find the Vignette status card and tap the refresh button."),
        ("Can I add multiple cars?", "Currently the app supports one car per account. Multiple car support will be available in a future update."),
        ("How do I upload documents?", "Go to the Documents tab and tap the + button. You can choose images from your photo library."),
        ("Is my data secure?", "Your data is stored locally on your device. We do not share your information with third parties."),
    ]

    var body: some View {
        List {
            ForEach(faqs, id: \.0) { question, answer in
                DisclosureGroup {
                    Text(answer)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 4)
                } label: {
                    Text(question)
                        .fontWeight(.medium)
                }
            }
        }
        .navigationTitle("FAQ")
    }
}

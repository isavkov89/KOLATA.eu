import SwiftUI

struct ServiceDetailView: View {
    let service: ServiceItem
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: service.icon)
                    .font(.system(size: 56))
                    .foregroundStyle(service.color)
                    .frame(width: 96, height: 96)
                    .background(service.color.opacity(0.12))
                    .clipShape(Circle())

                Text(service.title)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(service.subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                VStack(spacing: 12) {
                    switch service.type {
                    case .fineCheck:
                        ServiceActionButton(title: "Check Fines Online", icon: "globe") {
                            // Placeholder - would open fine check service
                        }
                    case .vignetteCheck:
                        ServiceActionButton(title: "Check Vignette Status", icon: "checkmark.shield") {
                            // Placeholder
                        }
                    case .repairShops:
                        ServiceActionButton(title: "Find on Map", icon: "map") {
                            // Placeholder - would open Maps with repair shop search
                        }
                    case .roadsideAssistance:
                        ServiceActionButton(title: "Call Assistance", icon: "phone") {
                            // Placeholder
                        }
                        ServiceActionButton(title: "SOS Number: 112", icon: "exclamationmark.triangle") {
                            if let url = URL(string: "tel://112") {
                                openURL(url)
                            }
                        }
                    case .insuranceBrokers:
                        ServiceActionButton(title: "Browse Offers", icon: "list.bullet") {
                            // Placeholder
                        }
                    case .gasStations:
                        ServiceActionButton(title: "Find on Map", icon: "map") {
                            // Placeholder
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                Text("This feature will be expanded in a future update.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .padding(.bottom)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

struct ServiceActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

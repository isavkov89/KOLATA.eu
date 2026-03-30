import SwiftUI

struct ServiceItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let type: ServiceType
}

enum ServiceType {
    case fineCheck
    case vignetteCheck
    case repairShops
    case roadsideAssistance
    case insuranceBrokers
    case gasStations
}

struct ServicesView: View {
    private let services: [ServiceItem] = [
        ServiceItem(title: "Fine Check", subtitle: "Check for traffic fines", icon: "exclamationmark.triangle", color: .red, type: .fineCheck),
        ServiceItem(title: "Vignette Check", subtitle: "Verify vignette validity", icon: "road.lanes", color: .blue, type: .vignetteCheck),
        ServiceItem(title: "Repair Shops", subtitle: "Find nearby repair shops", icon: "wrench.and.screwdriver", color: .orange, type: .repairShops),
        ServiceItem(title: "Roadside Assistance", subtitle: "Emergency help on the road", icon: "phone.arrow.up.right", color: .green, type: .roadsideAssistance),
        ServiceItem(title: "Insurance Brokers", subtitle: "Compare insurance offers", icon: "shield.checkered", color: .purple, type: .insuranceBrokers),
        ServiceItem(title: "Gas Stations", subtitle: "Find nearby gas stations", icon: "fuelpump", color: .cyan, type: .gasStations),
    ]

    @State private var selectedService: ServiceItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(services) { service in
                        ServiceCardView(service: service) {
                            selectedService = service
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Services")
            .sheet(item: $selectedService) { service in
                ServiceDetailView(service: service)
            }
        }
    }
}

struct ServiceCardView: View {
    let service: ServiceItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: service.icon)
                    .font(.title)
                    .foregroundStyle(service.color)
                    .frame(width: 48, height: 48)
                    .background(service.color.opacity(0.12))
                    .clipShape(Circle())

                VStack(spacing: 4) {
                    Text(service.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    Text(service.subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }
}

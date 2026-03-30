import SwiftUI
import SwiftData

struct StatusCardView: View {
    let car: Car
    let type: StatusType
    @State private var isChecking = false

    private var carStatus: CarStatus? {
        car.statuses.first(where: { $0.type == type })
    }

    private var currentStatus: ValidityStatus {
        carStatus?.computedStatus ?? .unknown
    }

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: type.icon)
                        .font(.title3)
                        .foregroundStyle(.tint)

                    Text(type.rawValue)
                        .font(.headline)

                    Spacer()

                    StatusBadge(status: currentStatus)
                }

                if let status = carStatus {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            if let expDate = status.expirationDate {
                                Label("Expires: \(expDate.formatted_ddMMyyyy)", systemImage: "calendar.badge.clock")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            if let checkedDate = status.lastCheckedDate {
                                Label("Checked: \(checkedDate.formatted_ddMMyyyy)", systemImage: "clock")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        Spacer()

                        Button {
                            Task { await refreshStatus() }
                        } label: {
                            if isChecking {
                                ProgressView()
                                    .controlSize(.small)
                            } else {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .disabled(isChecking)
                    }
                } else {
                    Button("Set Status") {
                        Task { await refreshStatus() }
                    }
                    .font(.subheadline)
                }
            }
        }
    }

    private func refreshStatus() async {
        isChecking = true
        do {
            let result = try await RegistryCheckService.shared.checkStatus(
                for: car.registrationNumber,
                type: type == .vignette ? .vignette : type == .technicalInspection ? .technicalInspection : .liabilityInsurance
            )

            if let existing = carStatus {
                existing.expirationDate = result.expirationDate
                existing.lastCheckedDate = result.checkedAt
                existing.source = result.source
            } else {
                let newStatus = CarStatus(
                    type: type,
                    status: result.isValid ? .valid : .expired,
                    expirationDate: result.expirationDate,
                    lastCheckedDate: result.checkedAt,
                    source: result.source
                )
                car.statuses.append(newStatus)
            }
        } catch {
            // Silently fail for MVP
        }
        isChecking = false
    }
}

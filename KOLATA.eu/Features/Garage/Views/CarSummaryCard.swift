import SwiftUI

struct CarSummaryCard: View {
    let car: Car

    var body: some View {
        GlassCard {
            HStack(spacing: 16) {
                Image(systemName: "car.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.tint)

                VStack(alignment: .leading, spacing: 4) {
                    Text(car.displayName)
                        .font(.title3)
                        .fontWeight(.semibold)

                    if !car.registrationNumber.isEmpty {
                        Text(car.registrationNumber)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    HStack(spacing: 12) {
                        if car.year > 0 {
                            Label("\(String(car.year))", systemImage: "calendar")
                        }
                        if !car.fuelType.isEmpty {
                            Label(car.fuelType, systemImage: "fuelpump")
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

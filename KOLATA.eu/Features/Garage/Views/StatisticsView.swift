import SwiftUI
import Charts

struct StatisticsView: View {
    let car: Car

    private var totalFuelCost: Double {
        car.fuelEntries.reduce(0) { $0 + $1.totalCost }
    }

    private var totalRepairCost: Double {
        car.repairs.reduce(0) { $0 + $1.cost }
    }

    private var totalTaxCost: Double {
        car.taxes.reduce(0) { $0 + $1.amount }
    }

    private var totalExpenses: Double {
        totalFuelCost + totalRepairCost + totalTaxCost
    }

    private var chartData: [(String, Double)] {
        [
            ("Fuel", totalFuelCost),
            ("Repairs", totalRepairCost),
            ("Taxes", totalTaxCost)
        ].filter { $0.1 > 0 }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Total expenses card
                GlassCard {
                    VStack(spacing: 8) {
                        Text("Total Expenses")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(totalExpenses.currencyFormatted)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                }

                // Breakdown
                if !chartData.isEmpty {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Breakdown")
                                .font(.headline)

                            Chart(chartData, id: \.0) { item in
                                SectorMark(
                                    angle: .value("Amount", item.1),
                                    innerRadius: .ratio(0.6),
                                    angularInset: 2
                                )
                                .foregroundStyle(by: .value("Category", item.0))
                                .cornerRadius(4)
                            }
                            .frame(height: 200)
                        }
                    }
                }

                // Category cards
                VStack(spacing: 12) {
                    StatCard(title: "Fuel", value: totalFuelCost, count: car.fuelEntries.count, icon: "fuelpump", color: .blue)
                    StatCard(title: "Repairs", value: totalRepairCost, count: car.repairs.count, icon: "wrench.and.screwdriver", color: .orange)
                    StatCard(title: "Taxes", value: totalTaxCost, count: car.taxes.count, icon: "banknote", color: .green)
                }
            }
            .padding()
        }
        .navigationTitle("Statistics")
    }
}

struct StatCard: View {
    let title: String
    let value: Double
    let count: Int
    let icon: String
    let color: Color

    var body: some View {
        GlassCard {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(value.currencyFormatted)
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()

                Text("\(count) entries")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

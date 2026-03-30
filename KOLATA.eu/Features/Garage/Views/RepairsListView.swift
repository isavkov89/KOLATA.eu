import SwiftUI

struct RepairsListView: View {
    let car: Car
    @State private var showAddRepair = false

    var body: some View {
        List {
            if car.repairs.isEmpty {
                ContentUnavailableView("No Repairs", systemImage: "wrench.and.screwdriver", description: Text("Tap + to add a repair record."))
            } else {
                ForEach(car.repairs.sorted(by: { $0.date > $1.date })) { repair in
                    NavigationLink {
                        EditRepairView(car: car, repair: repair)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(repair.title)
                                .fontWeight(.medium)
                            HStack {
                                Text(repair.date.formatted_ddMMyyyy)
                                if repair.cost > 0 {
                                    Text("•")
                                    Text(repair.cost.currencyFormatted)
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    let sorted = car.repairs.sorted(by: { $0.date > $1.date })
                    for index in offsets {
                        let repair = sorted[index]
                        if let idx = car.repairs.firstIndex(where: { $0.id == repair.id }) {
                            car.repairs.remove(at: idx)
                        }
                    }
                }
            }
        }
        .navigationTitle("Repairs")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAddRepair = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddRepair) {
            EditRepairView(car: car, repair: nil)
        }
    }
}

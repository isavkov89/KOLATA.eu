import SwiftUI

struct FuelListView: View {
    let car: Car
    @State private var showAddFuel = false

    var body: some View {
        List {
            if car.fuelEntries.isEmpty {
                ContentUnavailableView("No Fuel Entries", systemImage: "fuelpump", description: Text("Tap + to add a fuel entry."))
            } else {
                ForEach(car.fuelEntries.sorted(by: { $0.date > $1.date })) { entry in
                    NavigationLink {
                        EditFuelView(car: car, entry: entry)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(entry.liters.twoDecimalString) L")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(entry.totalCost.currencyFormatted)
                                    .fontWeight(.medium)
                            }
                            HStack {
                                Text(entry.date.formatted_ddMMyyyy)
                                if entry.odometer > 0 {
                                    Text("•")
                                    Text("\(entry.odometer) km")
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    let sorted = car.fuelEntries.sorted(by: { $0.date > $1.date })
                    for index in offsets {
                        let entry = sorted[index]
                        if let idx = car.fuelEntries.firstIndex(where: { $0.id == entry.id }) {
                            car.fuelEntries.remove(at: idx)
                        }
                    }
                }
            }
        }
        .navigationTitle("Fuel")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAddFuel = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddFuel) {
            EditFuelView(car: car, entry: nil)
        }
    }
}

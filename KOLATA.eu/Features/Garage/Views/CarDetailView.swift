import SwiftUI

struct CarDetailView: View {
    let car: Car
    @State private var showEditCar = false

    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    Image(systemName: "car.fill")
                        .font(.system(size: 40))
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
                    }
                }
                .listRowBackground(Color.clear)
            }

            Section("Manage") {
                NavigationLink {
                    CarInfoView(car: car)
                } label: {
                    Label("General Info", systemImage: "info.circle")
                }

                NavigationLink {
                    RepairsListView(car: car)
                } label: {
                    Label("Repairs", systemImage: "wrench.and.screwdriver")
                    Spacer()
                    Text("\(car.repairs.count)")
                        .foregroundStyle(.secondary)
                }

                NavigationLink {
                    FuelListView(car: car)
                } label: {
                    Label("Fuel", systemImage: "fuelpump")
                    Spacer()
                    Text("\(car.fuelEntries.count)")
                        .foregroundStyle(.secondary)
                }

                NavigationLink {
                    EventsListView(car: car)
                } label: {
                    Label("Events", systemImage: "calendar")
                    Spacer()
                    Text("\(car.events.count)")
                        .foregroundStyle(.secondary)
                }

                NavigationLink {
                    TaxesListView(car: car)
                } label: {
                    Label("Taxes", systemImage: "banknote")
                    Spacer()
                    Text("\(car.taxes.count)")
                        .foregroundStyle(.secondary)
                }
            }

            Section {
                NavigationLink {
                    StatisticsView(car: car)
                } label: {
                    Label("Statistics", systemImage: "chart.bar")
                }
            }
        }
        .navigationTitle("Car Details")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") { showEditCar = true }
            }
        }
        .sheet(isPresented: $showEditCar) {
            EditCarView(car: car)
        }
    }
}

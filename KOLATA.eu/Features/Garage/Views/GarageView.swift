import SwiftUI
import SwiftData

struct GarageView: View {
    @Query private var cars: [Car]
    @State private var showAddCar = false

    private var car: Car? { cars.first }

    var body: some View {
        NavigationStack {
            Group {
                if let car {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Car summary card
                            NavigationLink(destination: CarDetailView(car: car)) {
                                CarSummaryCard(car: car)
                            }
                            .buttonStyle(.plain)

                            // Status cards
                            VStack(spacing: 12) {
                                Text("Status")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                ForEach(StatusType.allCases, id: \.self) { type in
                                    StatusCardView(car: car, type: type)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    EmptyStateView(
                        icon: "car.fill",
                        title: "No Car Added",
                        message: "Add your car to start tracking its status and records.",
                        actionTitle: "Add Car"
                    ) {
                        showAddCar = true
                    }
                }
            }
            .navigationTitle("Garage")
            .toolbar {
                if car == nil {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showAddCar = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddCar) {
                AddCarView()
            }
        }
    }
}

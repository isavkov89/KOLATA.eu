import SwiftUI

struct EventsListView: View {
    let car: Car
    @State private var showAddEvent = false

    var body: some View {
        List {
            if car.events.isEmpty {
                ContentUnavailableView("No Events", systemImage: "calendar", description: Text("Tap + to add an event."))
            } else {
                ForEach(car.events.sorted(by: { $0.date > $1.date })) { event in
                    NavigationLink {
                        EditEventView(car: car, event: event)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .fontWeight(.medium)
                            HStack {
                                Text(event.date.formatted_ddMMyyyy)
                                Text("•")
                                Text(event.type)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    let sorted = car.events.sorted(by: { $0.date > $1.date })
                    for index in offsets {
                        let event = sorted[index]
                        if let idx = car.events.firstIndex(where: { $0.id == event.id }) {
                            car.events.remove(at: idx)
                        }
                    }
                }
            }
        }
        .navigationTitle("Events")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAddEvent = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddEvent) {
            EditEventView(car: car, event: nil)
        }
    }
}

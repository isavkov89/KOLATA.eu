import SwiftUI

struct TaxesListView: View {
    let car: Car
    @State private var showAddTax = false

    var body: some View {
        List {
            if car.taxes.isEmpty {
                ContentUnavailableView("No Tax Records", systemImage: "banknote", description: Text("Tap + to add a tax record."))
            } else {
                ForEach(car.taxes.sorted(by: { $0.dueDate > $1.dueDate })) { tax in
                    NavigationLink {
                        EditTaxView(car: car, tax: tax)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(tax.title)
                                    .fontWeight(.medium)
                                Spacer()
                                Text(tax.amount.currencyFormatted)
                                    .fontWeight(.medium)
                            }
                            HStack {
                                Text("Due: \(tax.dueDate.formatted_ddMMyyyy)")
                                Text("•")
                                Text(tax.status)
                                    .foregroundStyle(tax.status == "Paid" ? .green : .orange)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    let sorted = car.taxes.sorted(by: { $0.dueDate > $1.dueDate })
                    for index in offsets {
                        let tax = sorted[index]
                        if let idx = car.taxes.firstIndex(where: { $0.id == tax.id }) {
                            car.taxes.remove(at: idx)
                        }
                    }
                }
            }
        }
        .navigationTitle("Taxes")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAddTax = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddTax) {
            EditTaxView(car: car, tax: nil)
        }
    }
}

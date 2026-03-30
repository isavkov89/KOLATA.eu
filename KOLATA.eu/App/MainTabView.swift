import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Garage", systemImage: "car.fill", value: 0) {
                GarageView()
            }

            Tab("Services", systemImage: "wrench.and.screwdriver.fill", value: 1) {
                ServicesView()
            }

            Tab("Documents", systemImage: "doc.fill", value: 2) {
                DocumentsView()
            }

            Tab("Profile", systemImage: "person.fill", value: 3) {
                ProfileView()
            }
        }
    }
}

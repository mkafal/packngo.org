import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, contact
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "airplane")
                }
                .tag(Tab.home)

            ContactView()
                .tabItem {
                    Label("Book Now", systemImage: "paperplane.fill")
                }
                .tag(Tab.contact)
        }
        .accentColor(.brandRed)
    }
}

#Preview {
    ContentView()
}

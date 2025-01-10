import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showSidebar = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Notifications")
                    }
                    .tag(2)
                
                CartView()
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }
                    .tag(3)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(ColorTheme.navigation)
            
            // Sidebar overlay
            if showSidebar {
                SidebarView(isShowing: $showSidebar)
                    .transition(.move(edge: .trailing))
            }
        }
        .background(ColorTheme.background)
    }
}

#Preview {
    ContentView()
} 
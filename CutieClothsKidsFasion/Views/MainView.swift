import SwiftUI

struct MainView: View {
    @State private var selectedTab = "house"
    @State private var previousTab = "house"
    @State private var isTabBarVisible: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if selectedTab == "house" {
                        HomePageView(isTabBarVisible: $isTabBarVisible)
                            .transition(previousTab == "house" ? .move(edge: .leading) : .move(edge: .trailing))
                    } else if selectedTab == "magnifyingglass" {
                        CatalogPageView(daysToCheck: days)
                            .transition(previousTab == "magnifyingglass" ? .move(edge: .leading) : .move(edge: .trailing))
                    } else if selectedTab == "cart" {
                        Text("Cart Page") // Placeholder for Cart page
                    } else if selectedTab == "heart" {
                        Text("Wishlist Page") // Placeholder for Wishlist page
                    } else if selectedTab == "person" {
                        Text("Profile Page") // Placeholder for Profile page
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: selectedTab)
                Spacer()
                if isTabBarVisible {
                              TabBarView(selectedTab: $selectedTab)
                          }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

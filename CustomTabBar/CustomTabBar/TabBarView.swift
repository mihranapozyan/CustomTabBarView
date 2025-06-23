import SwiftUI


/// Enum representing all tab items in the application.
/// Each case has a raw string value for display and an associated SF Symbol image.
enum TabItems: String, CaseIterable {
    case home = "Home"
    case search = "Search"
    case notifications = "Notifications"
    case settings = "Settings"
    case profile = "Profile"
    
    var tabImage: String {
        switch self {
        case .home:
            "house"
        case .search:
            "magnifyingglass"
        case .notifications:
            "bell"
        case .settings:
            "gearshape"
        case .profile:
            "person.circle"
        }
    }
    
}

/// A custom tab bar view using SwiftUI.
/// Contains a `TabView` for page content and a stylized bottom tab bar.
/// The active tab is highlighted with a matched geometry effect.
struct TabBarView: View {
    @State private var activeTab: TabItems = .home
    @Namespace private var animation
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                ForEach(TabItems.allCases, id: \.rawValue) { item in
                    Text(item.rawValue)
                        .tag(item)
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            tabItemView(activeTab)
        }
    }
    
    /// Renders the bottom custom tab bar UI.
    /// Includes icons and labels for each `TabItems` case,
    /// with animation and highlighting for the selected tab.
    @ViewBuilder
    private func tabItemView(_ activeTab: TabItems) -> some View {
        HStack {
            ForEach(TabItems.allCases, id: \.rawValue) { item in
                tappedTabView(item)
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
        .background(.background.shadow(.drop(radius: 5)))
    }
    
    /// Renders an individual tab item in the tab bar.
    /// Applies size, color, and animation styling based on whether the tab is active.
    /// Updates `activeTab` when tapped.
    @ViewBuilder
    func tappedTabView(_ tab: TabItems) -> some View {
        let isActive = activeTab == tab
        
        VStack {
            Image(systemName: tab.tabImage)
                .symbolVariant(.fill)
                .frame(width: isActive ? 50 : 25, height: isActive ? 50 : 2)
                .background {
                    if isActive {
                        Circle()
                            .fill(.purple.gradient)
                            .matchedGeometryEffect(id: "SLIDE_TAB", in: animation)
                    }
                }
                .frame(width: 10, height: 25, alignment: .bottom)
                .foregroundStyle(isActive ? .white : .primary)
                .padding(.bottom, 12)
            Text(tab.rawValue)
                .font(.caption2)
                .foregroundColor(isActive ? .purple : .primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            withAnimation(.snappy) {
                activeTab = tab
            }
        }
    }
}

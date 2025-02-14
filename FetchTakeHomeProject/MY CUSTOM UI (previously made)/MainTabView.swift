//
//  MainTabView.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/22/24.
//

import SwiftUI

enum ActiveTab: String, CaseIterable, Identifiable {
    case homeView = "Feed"
    case favorites = "Favorites"
    case otherTab = "Other"
    
    var id: String {
        self.rawValue
    }
    
    var systemSymbol: String {
        switch self {
        case  .homeView: "list.star"
        case .favorites: "heart"
        case .otherTab: "questionmark"
        }
    }
    
    var View: some View {
        switch self {
        case .homeView: AnyView(HomeView())
        case .favorites: AnyView(FavoritesView())
        case .otherTab: AnyView(OtherView())
        }
    }
    
}

struct MainTabView: View {
    @State private var activeTab: ActiveTab = .homeView
    
    init() {}
    
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView(selection: $activeTab) {
                ForEach(ActiveTab.allCases) { tab in
                    Tab(tab.rawValue, systemImage: tab.systemSymbol, value: tab) {
                        tab.View
                    }
                }
            }
        } else {
            // fallback
            TabView(selection: $activeTab) {
                ActiveTab.homeView.View
                    .tabItem {
                        Label(ActiveTab.homeView.rawValue, systemImage: ActiveTab.homeView.systemSymbol)
                    }
                ActiveTab.favorites.View
                    .tabItem {
                        Label(ActiveTab.homeView.rawValue, systemImage: ActiveTab.homeView.systemSymbol)
                    }
                ActiveTab.otherTab.View
                    .tabItem {
                        Label(ActiveTab.homeView.rawValue, systemImage: ActiveTab.homeView.systemSymbol)
                    }
            }
            
        }
    }
}

#Preview {
    MainTabView()
}


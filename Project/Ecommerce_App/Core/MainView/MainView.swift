//
//  MainView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-12.
//

import SwiftUI

struct MainView: View {
    //MARK: - PROPERTIES
    @State private var tabSelection: TabBarItem = .home
    @EnvironmentObject private var homeVM: HomeViewModel
    
    //MARK: - BODY
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            HomeView()
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            FavoriteView(selection: $tabSelection)
                .tabBarItem(tab: .favorite, selection: $tabSelection)
            
            CartView(selection: $tabSelection)
                .tabBarItem(tab: .cart, selection: $tabSelection)
            
            ChatView(selection: $tabSelection)
                .tabBarItem(tab: .chat, selection: $tabSelection)
            
            SettingsView(selection: $tabSelection)
                .tabBarItem(tab: .settings, selection: $tabSelection)
        }
        .background(Color.generalTheme.pageBackground)
        .edgesIgnoringSafeArea(.bottom)
    }
}

//MARK: - PREVIEW
struct MainView_Previews: PreviewProvider {
    static let homeViewModel = HomeViewModel()
    static var previews: some View {
        MainView()
            .environmentObject(homeViewModel)
    }
}

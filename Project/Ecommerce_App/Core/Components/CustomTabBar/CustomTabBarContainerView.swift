//
//  CustomTabBarContainerView.swift
//  Horoscope
//
//  Created by Христиченко Александр on 2022-12-29.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    //MARK: - PROPERTIES
    let content: Content
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    
    //MARK: - INIT
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    //MARK: - BODY
    var body: some View {
        
        ZStack(alignment: .bottom) {
            //Content
            content
                .edgesIgnoringSafeArea(.top)
                .padding(.top)
            
            //Tabs
            CustomTabBarView(tabs: tabs, selection: $selection)
        } //ZStack
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

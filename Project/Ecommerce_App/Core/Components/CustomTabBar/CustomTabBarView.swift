//
//  CustomTabBarView.swift
//  Horoscope
//
//  Created by Христиченко Александр on 2022-12-29.
//

import SwiftUI

struct CustomTabBarView: View {
    //MARK: - PROPERTIES
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @EnvironmentObject private var homeVM: HomeViewModel
    
    //MARK: - BODY
    var body: some View {
        tabBarVersion
    }
}

//MARK: - PREVIEW
struct CustomTabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .home, .favorite, .cart, .chat, .settings
    ]
    static let homeViewModel = HomeViewModel()
    
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs[0]))
        }
        .environmentObject(homeViewModel)
    }
}

//MARK: - EXTENSIONS
extension CustomTabBarView {
    //Single tab
    private func tabView(tab: TabBarItem) -> some View {
        Image(tab.iconName)
            .resizable()
            .scaledToFit()
            .frame(height: 20)
            .foregroundColor(selection == tab ? Color.black : Color.gray)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(
                ZStack(content: {
                    if selection == tab {
                        Circle()
                            .frame(width: 45, height: 45, alignment: .center)
                            .foregroundColor(Color("SelectionColor"))
                            .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                    }
                })
            )
    }
    
    //All tabs
    private var tabBarVersion: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .overlay(alignment: .topTrailing, content: {
                        if tab == .cart {
                            ZStack {
                                Circle()
                                    .foregroundColor(.red)
                                Text("\(homeVM.buyItems.count)")
                                    .foregroundColor(Color.white)
                                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 12))
                            }
                            .frame(width: 20, height: 20, alignment: .center)
                            .opacity(homeVM.buyItems.isEmpty ? 0.0 : 1.0)
                            .offset(x: -7)
                        }
                        
                        if tab == .favorite {
                            ZStack {
                                Circle()
                                    .foregroundColor(.red)
                                Text("\(homeVM.favoriteItems.count)")
                                    .foregroundColor(Color.white)
                                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 12))
                            }
                            .frame(width: 20, height: 20, alignment: .center)
                            .opacity(homeVM.favoriteItems.isEmpty ? 0.0 : 1.0)
                            .offset(x: -7)
                        }
                    })
                    .onTapGesture {
                        self.switchToTab(tab: tab)
                    }
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 40)
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, alignment: .center)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

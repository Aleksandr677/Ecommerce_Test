//
//  FavoriteView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-12.
//

import SwiftUI

struct FavoriteView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject private var homeVM: HomeViewModel
    @Binding var selection: TabBarItem
    
    //MARK: - BODY
    var body: some View {
        VStack {
            header
            if !homeVM.favoriteItems.isEmpty {
                List {
                    ForEach(homeVM.favoriteItems, id: \.id) { item in
                        DefaultItemRow(buyItem: item, action: {
                            DispatchQueue.main.async {
                                withAnimation {
                                    homeVM.favoriteItems.removeAll(where: { $0 == item })
                                }
                            }
                        })
                    }
                    .onDelete { indexSet in
                        withAnimation(.linear) {
                            homeVM.favoriteItems.remove(atOffsets: indexSet)
                        }
                    }
                }
                .listStyle(.automatic)
                .cornerRadius(15)
            }
            Spacer()
        }
        .background(Color.generalTheme.pageBackground)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - PREVIEW
struct FavoriteView_Previews: PreviewProvider {
    static let homeViewModel = HomeViewModel()
    static var previews: some View {
        FavoriteView(selection: .constant(.home))
            .environmentObject(homeViewModel)
    }
}

//MARK: - EXTENTIONS
extension FavoriteView {
    private var header: some View {
        HStack {
            Button(action: {
                withAnimation(.linear) {
                    selection = .home
                }
            },
                   label: {
                Image(systemName: "arrow.left")
                    .padding(.leading, 10)
                    .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 20))
                    .foregroundColor(.black)
            }) //Button
            Spacer()
            Text("Favorite Items")
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 20))
                .offset(x: -15)
            Spacer()
        } //HStack
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

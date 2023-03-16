//
//  LatestItem.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-13.
//

import SwiftUI

struct LatestItem: View {
    //MARK: - PROPERTIES
    let latestItem: ItemLatestCategory
    @Binding var isLoaded: Bool
    @State private var image: Image = Image("")
    @EnvironmentObject private var homeVM: HomeViewModel
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            if isLoaded {
                imageBackground
                VStack(alignment: .leading) {
                    Spacer()
                    category
                    title
                    
                    HStack {
                        price
                        Spacer()
                        addButton
                    } //HStack
                } //VStack
                .padding(.leading, 7)
            } else {
                ZStack {
                    Color.registerTheme.titleColor.opacity(0.7)
                    ProgressView()
                }
            }
        } //ZStack
        .frame(width: 115, height: 150)
        .cornerRadius(12)
    }
}

struct LatestItem_Previews: PreviewProvider {
    
    static let homeViewModel = HomeViewModel()
    static var previews: some View {
        LatestItem(latestItem: ItemLatestCategory(category: "Phones", name: "Samsung S10", price: 1000, image: "https://www.dhresource.com/0x0/f2/albu/g8/M01/9D/19/rBVaV1079WeAEW-AAARn9m_Dmh0487.jpg"), isLoaded: .constant(true))
            .previewLayout(.sizeThatFits)
            .environmentObject(homeViewModel)
    }
}

extension LatestItem {
    private var imageBackground: some View {
        AsyncImage(url: URL(string: latestItem.image)) { image in
            image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 115, height: 150)
                .cornerRadius(10)
                .onAppear {
                    self.image = image
                }
        } placeholder: {
            EmptyView()
        }
    }
    
    private var category: some View {
        Text(latestItem.category)
            .padding(.vertical, 3)
            .padding(.horizontal, 8)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.generalTheme.pageBackground.opacity(0.8))
            })
            .foregroundColor(Color.black)
            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 10))
    }
    
    private var title: some View {
        Text(latestItem.name)
            .foregroundColor(Color.black)
            .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 10))
            .lineLimit(2)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background {
                RoundedRectangle(cornerRadius: 7)
                    .foregroundColor(Color.generalTheme.pageBackground.opacity(0.8))
            }
            .padding(.bottom, 12)
    }
    
    private var price: some View {
        Text("\(latestItem.price.asCurrencyWith2Decimals())")
            .foregroundColor(Color.black)
            .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 10))
            .lineLimit(1)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background {
                RoundedRectangle(cornerRadius: 7)
                    .foregroundColor(Color.generalTheme.pageBackground.opacity(0.8))
            }
            .padding(.bottom, 12)
    }
    
    private var addButton: some View {
        Button(action: {
            homeVM.addItemToFavorite(price: latestItem.price, name: latestItem.name, image: self.image)
        },
               label: {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 7, height: 7)
                .fontWeight(.bold)
                .padding(5)
                .background(
                    Circle()
                        .foregroundColor(Color.generalTheme.pageBackground)
                        .frame(width: 20, height: 20)
                )
        })
        .padding(.bottom, 10)
        .padding(.trailing, 8)
    }
}

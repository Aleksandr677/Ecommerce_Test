//
//  FlashSaleItem.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-14.
//

import SwiftUI

struct FlashSaleItem: View {
    //MARK: - PROPERTIES
    let flashSaleItem: ItemFlashSaleCategory
    @Binding var isLoaded: Bool
    @State private var image: Image = Image("")
    @EnvironmentObject private var homeVM: HomeViewModel
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            if isLoaded {
                imageBackground
                VStack(alignment: .leading) {
                    discount
                    Spacer()
                    category
                    title
                    HStack(alignment: .center) {
                        price
                        likeButton
                        addButton
                    } //HStack
                } //VStack
                .padding(.horizontal, 15)
                .padding(.vertical)
            } else {
                ZStack {
                    Color.registerTheme.titleColor.opacity(0.7)
                    ProgressView()
                }
            } //ZStack
        } //ZStack
        .frame(width: UIScreen.main.bounds.width/2 - 15, height: 230)
        .cornerRadius(15)
    }
}

//MARK: - PREVIEW
struct FlashSaleItem_Previews: PreviewProvider {
    static let homeViewModel = HomeViewModel()
    static var previews: some View {
        FlashSaleItem(flashSaleItem: ItemFlashSaleCategory(category: "Kids", name: "New Balance Sneakers", price: 22.5, discount: 30, image: "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg"), isLoaded: .constant(true))
            .environmentObject(homeViewModel)
    }
}

//MARK: - EXTENTIONS
extension FlashSaleItem {
    private var imageBackground: some View {
        AsyncImage(url: URL(string: flashSaleItem.image)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/2 - 15, height: 230)
                .background(Color.white)
                .cornerRadius(10)
                .clipped()
                .onAppear {
                    self.image = image
                }
        } placeholder: {
            EmptyView()
        }
    }
    
    private var discount: some View {
        HStack {
            Spacer()
            Text("\(flashSaleItem.discount)% off")
                .foregroundColor(Color.white)
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 10))
                .padding(5)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.generalTheme.orange)
                )
        }
        .frame(maxWidth: .infinity)
    }
    
    private var category: some View {
        Text(flashSaleItem.category)
            .padding(.vertical, 3)
            .padding(.horizontal, 8)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.generalTheme.pageBackground.opacity(0.8))
            })
            .foregroundColor(Color.black)
            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 12))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var title: some View {
        Text(flashSaleItem.name)
            .foregroundColor(Color.black)
            .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 12))
            .padding(.vertical, 3)
            .padding(.horizontal, 8)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.generalTheme.pageBackground.opacity(0.8))
            })
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .padding(.bottom, 12)
    }
    
    private var price: some View {
        Text("\(flashSaleItem.price.asCurrencyWith2Decimals())")
            .foregroundColor(Color.black)
            .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 11))
            .lineLimit(nil)
            .padding(.vertical, 3)
            .padding(.horizontal, 8)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.generalTheme.pageBackground.opacity(0.8))
            })
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var likeButton: some View {
        Button(action: {
            //do something here
        },
               label: {
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .fontWeight(.bold)
                .padding(8)
                .foregroundColor(Color.generalTheme.accent)
                .background(
                    Circle()
                        .foregroundColor(Color.generalTheme.pageBackground)
                        .frame(width: 27, height: 27)
                )
        })
        .padding(2)
    }
    
    private var addButton: some View {
        Button(action: {
            homeVM.addItemToFavorite(price: flashSaleItem.price, name: flashSaleItem.name, image: self.image)
        },
               label: {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .fontWeight(.bold)
                .foregroundColor(Color.generalTheme.accent)
                .padding(5)
                .background(
                    Circle()
                        .foregroundColor(Color.generalTheme.pageBackground)
                        .frame(width: 35, height: 35)
                )
        })
    }
}

//
//  DefaultCartRow.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-16.
//

import SwiftUI

struct DefaultItemRow: View {
    //MARK: - PROPERTIES
    let buyItem: BuyItem
    let action: () -> ()
    
    //MARK: - BODY
    var body: some View {
        HStack {
            buyItem.image
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .cornerRadius(15)
            VStack(alignment: .leading, spacing: 5) {
                Text(buyItem.name)
                    .foregroundColor(Color.registerTheme.purple)
                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 15))
                    .lineLimit(1)
                Text("Total price:  \(buyItem.price.asCurrencyWith2Decimals())")
                    .foregroundColor(Color.registerTheme.purple)
                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 13))
                HStack(alignment: .bottom) {
                    Text("Choosen color:")
                        .foregroundColor(Color.registerTheme.purple)
                        .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 13))
                    buyItem.color
                        .frame(width: 25, height: 25)
                        .cornerRadius(5)
                }
            }
            Spacer()
            Button(action: action,
                   label: {
                Image(systemName: "trash")
                    .foregroundColor(Color.generalTheme.accent)
                    .font(.title2)
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//MARK: - PREVIEW
struct DefaultItemRow_Previews: PreviewProvider {
    static var previews: some View {
        DefaultItemRow(buyItem: BuyItem(name: "iPhone", price: 150.00006, image: Image("photo"), color: Color.blue), action: {})
    }
}

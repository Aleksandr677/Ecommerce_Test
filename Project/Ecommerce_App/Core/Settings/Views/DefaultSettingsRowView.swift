//
//  DefaultSettingsRowView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-12.
//

import SwiftUI

struct DefaultSettingsRowView: View {
    //MARK: - PROPERTIES
    let image: String
    let title: String
    let button: String?
    let buttonTitle: String?
    
    //MARK: - BODY
    var body: some View {
        HStack {
            HStack(spacing: 20) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .background {
                        Circle()
                            .foregroundColor(Color.registerTheme.selection)
                            .frame(width: 50, height: 50)
                    }
                
                Text(title)
                    .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 16))
                    .foregroundColor(.black)
            } //HStack
            Spacer()
            if button != nil {
                Button(action: {
                    
                },
                       label: {
                    Image(systemName: button ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: button == nil ? 0 : 10)
                        .background {Color.clear.frame(width: 55)}
                })
            }
            if buttonTitle != nil {
                Text(buttonTitle ?? "")
                    .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 16))
                    .foregroundColor(.black)
                    .frame(maxWidth: buttonTitle == nil ? 0 : 50, alignment: .trailing)
                    .lineLimit(1)
            }
        } //HStack
        .frame(maxWidth: .infinity)
    }
}

//MARK: - PREVIEW
struct DefaultSettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultSettingsRowView(image: "wallet", title: "Trade store", button: "chevron.right", buttonTitle: "1234")
    }
}

//
//  SignInOptionRow.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import SwiftUI

struct SignInOptionRow: View {
    //MARK: - PROPERTIES
    let imageName: String
    let title: String
    
    //MARK: - BODY
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 20)
            
            Text(title)
                .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 18))
                .shadow(color: Color.black.opacity(0.3), radius: 2, y: 5)
                .foregroundColor(.black)
        }
        .onTapGesture {
            print("DEBUG: button \(title.uppercased()) was pressed")
        }
    }
}

//MARK: - PREVIEW
struct SignInOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        SignInOptionRow(imageName: "appleIcon", title: "Sign in with Apple")
    }
}

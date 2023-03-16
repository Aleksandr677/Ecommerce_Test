//
//  ViewAllRow.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-14.
//

import SwiftUI

struct ViewAllRow: View {
    //MARK: - PROPERTIES
    let title: String
    
    //MARK: - BODY
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 15))
                .foregroundColor(.black)
            Spacer()
            Text("View all")
                .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 11))
                .foregroundColor(Color.generalTheme.accent)
        } //HStack
        .frame(maxWidth: .infinity)
    }
}

//MARK: - PREVIEW
struct ViewAllRow_Previews: PreviewProvider {
    static var previews: some View {
        ViewAllRow(title: "Latest")
    }
}

//
//  SwiftUIView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-15.
//

import SwiftUI

struct DetailImageView: View {
    //MARK: - PROPERTIES
    @Binding var image: Image
    
    //MARK: - BODY
    var body: some View {
        image
            .resizable()
            .aspectRatio(1.05, contentMode: .fill)
            .cornerRadius(15)
            .frame(width: UIScreen.main.bounds.width - 30, height: 250)
    }
}

//MARK: - PREVEIW
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(image: .constant(Image("photo")))
    }
}

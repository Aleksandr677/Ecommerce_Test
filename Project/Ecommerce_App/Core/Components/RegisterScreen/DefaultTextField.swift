//
//  DefaultTextField.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import SwiftUI

struct DefaultTextField: View {
    let placeholder: String
    @Binding var textFieldInput: String
    var showIcon: Bool? = false
    
    var body: some View {
        TextField("", text: $textFieldInput)
            .placeholder(when: textFieldInput.isEmpty) {
                if !(showIcon ?? false) {
                    Text(placeholder)
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 15))
                } else {
                    HStack {
                        Spacer()
                        Text(placeholder)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(x: 15)
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding(.trailing, 25)
                    }
                    .foregroundColor(Color.gray)
                    .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 15))
                }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 35)
            .background(Color.registerTheme.titleColor)
            .cornerRadius(15)
    }
}

struct DefaultTextField_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTextField(placeholder: "First name", textFieldInput: .constant(""), showIcon: true)
    }
}

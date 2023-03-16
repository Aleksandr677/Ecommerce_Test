//
//  PasswordTextfield.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import SwiftUI

struct PasswordTextfield: View {
    //MARK: - PROPERTIES
    @Binding var text: String
    @State private var isSecure: Bool = true
    var placeholder: String
    
    //elert message
    @State private var alertErrorMessage: String = ""
    @State private var showAlert: Bool = false
    
    //MARK: - BODY
    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .offset(x:!text.isEmpty ? 35 : 0)
            } else {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 15))
                    }
                    .offset(x:!text.isEmpty ? 35 : 0)
            }
            
            if !text.isEmpty {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "info.circle")
                        .onTapGesture {
                            showAlert.toggle()
                        }
                    
                    Image(systemName: isSecure ? "eye.slash" : "eye" )
                        .padding(.trailing)
                        .onTapGesture {
                            isSecure.toggle()
                        }
                } //HStack
            }
        } //HStack
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 35)
        .background(Color.registerTheme.titleColor)
        .cornerRadius(15)
        .alert("Password", isPresented: $showAlert, actions: {}, message: {
            Text("Your password must contain at least 6 characters.")
        })
    }
}

//MARK: - PREVIEW
struct PasswordTextfield_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextfield(text: .constant(""), placeholder: "Password")
    }
}

//
//  ChatView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-12.
//

import SwiftUI

struct ChatView: View {
    //MARK: - PROPERTIES
    @Binding var selection: TabBarItem
    
    //MARK: - BODY
    var body: some View {
        VStack {
            header
            Spacer()
        }
        .background(Color.generalTheme.pageBackground)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - PREVIEW
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(selection: .constant(.home))
    }
}

//MARK: - EXTENTIONS
extension ChatView {
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
            Text("Chat")
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 20))
                .offset(x: -15)
            Spacer()
        } //HStack
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

//
//  SelectCategoryGrid.swift
//  Ecommerce Concept
//
//  Created by Христиченко Александр on 2022-12-02.
//

import SwiftUI

struct SelectCategoryGrid: View {
    //MARK: - PROPERTIE
    private let categories = SelectCategory.selectCategoryData
    @State private var selection = SelectCategory.selectCategoryData[0]
    @Namespace private var categoryNamespace
    
    //MARK: - BODY
    var body: some View {
        //First row of signs
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories, id: \.id) { category in
                    VStack(spacing: 15) {
                        Image(category.itemImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .background(
                                ZStack(content: {
                                    if selection == category {
                                        Circle()
                                            .frame(width: 60, height: 60, alignment: .center)
                                            .foregroundColor(Color("SelectionColor"))
                                            .matchedGeometryEffect(id: "background_rectangle", in: categoryNamespace)
                                    }
                                })
                            )
                            .padding()
                        
                        Text(category.itemName)
                            .foregroundColor(Color.generalTheme.accent)
                            .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 13))
                    } //VStack
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)) {
                            selection = category
                        }
                    }
                } //Loop
            } //HStack
            .padding(5)
        } //Scroll
        .padding(.horizontal, 10)
        .padding(.top, 17)
    }
}

//MARK: - PREVIEW
struct SelectCategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoryGrid()
    }
}

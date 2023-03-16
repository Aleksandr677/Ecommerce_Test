//
//  Modifiers.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import Foundation
import SwiftUI

//Fonts
struct FontModifier : ViewModifier {
    let fontName: String
    let fontSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(fontName, size: fontSize))
    }
}

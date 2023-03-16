//
//  Color.swift
//  Cryptonos
//
//  Created by Христиченко Александр on 2023-02-07.
//

import SwiftUI

extension Color {
    static let generalTheme = GeneralColorTheme()
    static let registerTheme = RegisterColorTheme()
}

struct GeneralColorTheme {
    let accent = Color("AccentColor")
    let pageBackground = Color("PageBackground")
    let orange = Color("Orange")
    let deepBlack = Color("DeepBlack")
}

struct RegisterColorTheme {
    let purple = Color("PurpleColor")
    let titleColor = Color("TitleColor")
    let selection = Color("SelectionColor")
}

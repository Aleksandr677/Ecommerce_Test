//
//  TabBarItem.swift
//  Horoscope
//
//  Created by Христиченко Александр on 2022-12-29.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
case home, favorite, cart, chat, settings
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorite: return "heart"
        case .cart: return "cart"
        case .chat: return "message"
        case .settings: return "person"
        }
    }
}

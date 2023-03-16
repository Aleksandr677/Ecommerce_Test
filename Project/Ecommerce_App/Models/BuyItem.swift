//
//  BuyItem.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-16.
//

import Foundation
import SwiftUI

struct BuyItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: Double
    let image: Image
    let color: Color?
    
    init(name: String, price: Double, image: Image, color: Color? = nil) {
        self.name = name
        self.price = price
        self.image = image
        self.color = color
    }
}

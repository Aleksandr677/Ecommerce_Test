//
//  SelectCategoryModel.swift
//  Test_App
//
//  Created by Христиченко Александр on 2022-08-23.
//

import Foundation

struct SelectCategory: Identifiable, Equatable {
    let id: Int
    let itemImage: String
    let itemName: String
    
    static let selectCategoryData: [SelectCategory] = [
        SelectCategory(id: 1, itemImage: "phone", itemName: "Phones"),
        SelectCategory(id: 2, itemImage: "headphones", itemName: "Headphones"),
        SelectCategory(id: 3, itemImage: "gamepad", itemName: "Games"),
        SelectCategory(id: 4, itemImage: "car", itemName: "Cars"),
        SelectCategory(id: 5, itemImage: "bed", itemName: "Furniture"),
        SelectCategory(id: 6, itemImage: "game", itemName: "Kids"),
    ]
}

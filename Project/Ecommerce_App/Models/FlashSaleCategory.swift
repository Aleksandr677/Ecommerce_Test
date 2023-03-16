//
//  FlashSaleCategory.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-14.
//

import Foundation

//FLASH SALE API
/*
 URL: https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac
 
 JSON RESPONSE:
 {
   "flash_sale": [
     {
       "category": "Kids",
       "name": "New Balance Sneakers",
       "price": 22.5,
       "discount": 30,
       "image_url": "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg"
     },
     {
       "category": "Kids",
       "name": "Reebok Classic",
       "price": 24,
       "discount": 30,
       "image_url": "https://assets.reebok.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/3613ebaf6ed24a609818ac63000250a3_9366/Classic_Leather_Shoes_-_Toddler_White_FZ2093_01_standard.jpg"
     }
   ]
 }
 */

struct FlashSaleCategory: Codable {
    let flashSale: [ItemFlashSaleCategory]
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

struct ItemFlashSaleCategory: Codable, Hashable {
    let category: String
    let name: String
    let price: Double
    let discount: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case image = "image_url"
    }
}

//
//  LatestCategory.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-13.
//

import Foundation

//Latest API
/*
 URL: https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7
 
 JSON RESPONSE:
 {
   "latest": [
     {
       "category": "Phones",
       "name": "Samsung S10",
       "price": 1000,
       "image_url": "https://www.dhresource.com/0x0/f2/albu/g8/M01/9D/19/rBVaV1079WeAEW-AAARn9m_Dmh0487.jpg"
     },
     {
       "category": "Games",
       "name": "Sony Playstation 5",
       "price": 700,
       "image_url": "https://avatars.mds.yandex.net/get-mpic/6251774/img_id4273297770790914968.jpeg/orig"
     },
     {
       "category": "Games",
       "name": "Xbox ONE",
       "price": 500,
       "image_url": "https://www.tradeinn.com/f/13754/137546834/microsoft-xbox-xbox-one-s-1tb-console-additional-controller.jpg"
     },
     {
       "category": "Cars",
       "name": "BMW X6M",
       "price": 35000,
       "image_url": "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg"
     }
   ]
 }
 */

struct LatestCategory: Codable {
    let latest: [ItemLatestCategory]
}

struct ItemLatestCategory: Codable, Hashable {
    let category: String
    let name: String
    let price: Double
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case category, name, price
        case image = "image_url"
    }
}

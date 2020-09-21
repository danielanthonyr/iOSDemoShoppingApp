//
//  Product.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    var id: Int
    var title: String
    var brand: String
    var short_description: String
    var description: String
    var price: Double
    var image: String
    var colors: [Colors]?
    var size: Size
    var quantity: Int
    var rating: Int?
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

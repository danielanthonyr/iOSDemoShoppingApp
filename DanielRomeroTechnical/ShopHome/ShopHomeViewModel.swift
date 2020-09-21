//
//  ShopListViewModel.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.

import Foundation

class ShopHomeViewModel: ObservableObject {
    @Published var products = [Product]()
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "catalogue", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(Initial.self, from: data)
                    self.products = result.products
                }
                catch {
                    print(error)
                }
            }
        } else {
        print("Error loading JSON URL")
        }
    }
    
    func getSubTotal(products: [Product]) -> Double {
            var total = 0.0
            for product in products {
                total = total + product.price
            }
            return total
    }
}


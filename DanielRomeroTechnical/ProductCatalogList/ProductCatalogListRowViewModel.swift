//
//  ProductCatalogListRowViewModel.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

class ProductCatalogListRowViewModel: ObservableObject {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
}

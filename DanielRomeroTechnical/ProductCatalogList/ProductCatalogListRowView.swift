//
//  ProductCatalogListRowView.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import SwiftUI

struct ProductCatalogListRowView: View {
    var viewModel: ProductCatalogListRowViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 150, height: 160, alignment: .center)
                .cornerRadius(8)
            
            VStack() {
                ImageView(withURL: self.viewModel.product.image, isComingFromHomepage: true)
                
                Text("\(self.viewModel.product.title)")
                    .bold()
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .padding(10)
                
            }.frame(width: 150, height: 160, alignment: .top)
        }
    }
}

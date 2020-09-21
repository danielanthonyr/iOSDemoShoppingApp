//
//  ProductWishlistListView.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.

import SwiftUI

struct ProductWishlistListRowView: View {
    var viewModel: ProductWishlistListRowViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
            
            HStack {
                ImageView(withURL: self.viewModel.product.image, isComingFromHomepage: true)
                
                VStack(alignment: .leading) {
                    Text("$\(self.viewModel.product.price, specifier: "%.2f")")
                    
                    Text("\(self.viewModel.product.title)")
                        .font(.headline)
                    
                    Text("\(self.viewModel.product.short_description)")
                    
                    if self.viewModel.product.colors != nil {
                        HStack {
                            ForEach(self.viewModel.product.colors! , id: \.self) { color in
                                Rectangle()
                                    .fill(Color(hex: "\(color.code)"))
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    
                    if self.viewModel.product.quantity == 0 {
                        Text("Out of stock")
                            .foregroundColor(Color.red)
                            .bold()
                    }
                }
                Spacer()
                
                Image(systemName: "arrow.right")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    .foregroundColor(Color.blue)
            }
        }
    }
}

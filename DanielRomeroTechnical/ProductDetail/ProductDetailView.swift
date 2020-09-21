//
//  ProductDetailView.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.

import SwiftUI

// Product details (Screen 1-1, 1-2)
struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    @EnvironmentObject var wishlist: UserWishlist
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        productDetails
    }
}

private extension ProductDetailView {
    var productDetails: some View {
        GeometryReader { geometry in
            VStack {
                ImageView(withURL: self.viewModel.product.image, isComingFromHomepage: false)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 350)
                
                VStack {
                    self.productDescription
                        .frame(width: geometry.size.width * 0.98)
                    
                    self.rateProductSection
                        .frame(width: geometry.size.width * 0.98)
                    
                    if self.wishlist.wishlistProducts.contains(self.viewModel.product) {
                        self.removeFromWishlistButton
                            .frame(width: geometry.size.width * 0.85)
                    } else {
                        self.addToWishlistButton
                            .frame(width: geometry.size.width * 0.85)
                    }
                    
                }
                .offset(y: -100)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(red: 237/255, green: 239/255, blue: 241/255))
        }
    }
    
    var productDescription: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .cornerRadius(8)
                .padding(15)
                .shadow(color: .gray, radius: 5, x: 0, y: -0.01)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("$\(viewModel.product.price, specifier: "%.2f")").font(.largeTitle)
                    Text("Free Shipping World Wide").foregroundColor(Color(hex: "#7CBFB4"))
                }
                
                Divider().padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                Text(viewModel.product.description).fixedSize(horizontal: false, vertical: true)
                
                coloursChoice
                
                sizeChoice
            }.padding(20)
        }
    }
    
    var rateProductSection: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 70)
                .cornerRadius(8)
            
            HStack {
                Text("Rate the product")
                    .bold()
                    .frame(width: 70, height: 70)
                
                Spacer()
                RatingView()
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }.padding(EdgeInsets(top: -10, leading: 15, bottom: 0, trailing: 15))
    }
    
    var coloursChoice: some View {
        HStack(spacing: 30) {
            Text("Colours").bold()
            
            if self.viewModel.product.colors != nil {
                HStack {
                    ForEach(self.viewModel.product.colors! , id: \.self) { color in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "\(color.code)"))
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
    }
    
    var sizeChoice: some View {
        HStack(spacing: 60) {
            Text("Size").bold()
            VStack(alignment: .leading) {
                Text("H: \(self.viewModel.product.size.H)")
                Text("W: \(self.viewModel.product.size.W)")
                Text("D: \(self.viewModel.product.size.D)")
            }
        }
    }
    
    var addToWishlistButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.red)
                .cornerRadius(8)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
            
            
            Text("Add to wish list")
                .bold()
                .foregroundColor(Color.white)
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    self.wishlist.wishlistProducts.append(self.viewModel.product)
                    self.presentation.wrappedValue.dismiss()
                }
        )
    }
    
    var removeFromWishlistButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.black)
                .cornerRadius(8)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
            
            Text("Remove from wish list")
                .bold()
                .foregroundColor(Color.white)
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    while let idx = self.wishlist.wishlistProducts.firstIndex(of:self.viewModel.product) {
                        self.wishlist.wishlistProducts.remove(at: idx)
                    }
                    self.presentation.wrappedValue.dismiss()
                }
        )
    }
}

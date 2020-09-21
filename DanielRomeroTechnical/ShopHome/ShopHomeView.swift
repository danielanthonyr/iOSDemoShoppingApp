//
//  ShopListView.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.

import SwiftUI

// Homepage view (Screen 1 & 1-4)
struct ShopHomeView: View {
    var viewModel: ShopHomeViewModel
    @EnvironmentObject var wishlist: UserWishlist
    @State private var areYouSureAlert = false
    
    var body: some View {
        return NavigationView {
            VStack {
                self.productCatalogView(products: self.viewModel.products)
                
                self.productWishlistView(products: wishlist.wishlistProducts)
                
                Divider()
                
                self.checkoutView()
                    .alert(isPresented: $areYouSureAlert) {
                        Alert(title: Text("Are you sure you want to proceed to checkout"),
                              primaryButton: .default(Text("OK").bold()) {
                                self.wishlist.wishlistProducts.removeAll()
                            }, secondaryButton: .cancel())
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(red: 235/255, green: 236/255, blue: 240/255))
            .navigationBarTitle(Text("TASCH").bold(), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension ShopHomeView {
    func productCatalogView(products: [Product]) -> some View {
        VStack(alignment: .leading) {
            Text("Product Catalog")
                .bold()
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(products, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: product))) {
                            ProductCatalogListRowView(viewModel: ProductCatalogListRowViewModel(product: product))
                                .padding(5)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }.background(Color(red: 216/255, green: 214/255, blue: 214/255))
    }
    
    @ViewBuilder
    func productWishlistView(products: [Product]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                HStack {
                    Text("Your wish list")
                        .bold()
                    Spacer()
                    Text("Total $\(viewModel.getSubTotal(products: self.wishlist.wishlistProducts), specifier: "%.2f")")
                }.padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                
                ForEach(products, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: product))) {
                        ProductWishlistListRowView(viewModel: ProductWishlistListRowViewModel(product: product))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    func checkoutView() -> some View {
        VStack {
            HStack {
                Text("Sub-Total").bold()
                Text("$\(viewModel.getSubTotal(products: self.wishlist.wishlistProducts), specifier: "%.2f")")
            }
            
            Text("Free Shipping World Wide").foregroundColor(Color(hex: "#7CBFB4"))
            
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.red)
                    .cornerRadius(8)
                    .frame(width: 250,height: 50)
                
                Text("Proceed to check out")
                    .bold()
                    .foregroundColor(Color.white)
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.areYouSureAlert = true
                }
            )
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
}

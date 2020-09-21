//
//  ImageView.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.

import Foundation
import Combine
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    var isComingFromHomepage: Bool
    
    init(withURL url:String, isComingFromHomepage: Bool) {
        imageLoader = ImageLoader(urlString:url)
        self.isComingFromHomepage = isComingFromHomepage
    }
    
    @ViewBuilder
    var body: some View {
        if isComingFromHomepage {
            shopHomeViewImageView
        } else {
            detailViewImageView
        }
    }
}

private extension ImageView {
    var shopHomeViewImageView: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 120, alignment: .top)
            
        }.onReceive(imageLoader.dataPublisher) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
    
    var detailViewImageView: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 350)
            
        }.onReceive(imageLoader.dataPublisher) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

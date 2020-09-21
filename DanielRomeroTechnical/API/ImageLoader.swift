//
//  ImageLoader.swift
//  DanielRomeroTechnical
//
//  Created by Daniel Romero on 2020-09-20.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation
import Combine

// Class that allows to load images from server asynchronously
class ImageLoader: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
        var data = Data() {
            didSet {
                dataPublisher.send(data)
            }
         }
    
    init(urlString:String) {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
               self.data = data
            }
        }
        task.resume()
      }
}

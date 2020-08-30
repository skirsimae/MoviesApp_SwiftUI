//
//  ImageFetcher.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 05/07/2020.
//  Copyright © 2020 Silva. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

//class ImageFetcher: ObservableObject {
//    @Published var image: UIImage?
//    private let url: URL
//    private var cancellable: AnyCancellable?
//
//    init(url: URL) {
//        self.url = url
//    }
//
//    deinit {
//        cancellable?.cancel()
//    }
//
//    func load() {
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .replaceError(with: nil)
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.image, on: self)
//    }
//
//    func cancel() {
//        cancellable?.cancel()
//    }
//}


class ImageFetcher: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            dataPublisher.send(data)
        }
     }
    
    init(urlString: String) {
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

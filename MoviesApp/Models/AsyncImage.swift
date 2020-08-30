//
//  AsyncImage.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 05/07/2020.
//  Copyright © 2020 Silva. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

//struct AsyncImage<Placeholder: View>: View {
//    @ObservedObject private var loader: ImageFetcher
//    private let placeholder: Placeholder?
//
//    init(url: URL, placeholder: Placeholder? = nil) {
//        loader = ImageFetcher(url: url)
//        self.placeholder = placeholder
//    }
//
//    var body: some View {
//        image
//            .onAppear(perform: loader.load)
//            .onDisappear(perform: loader.cancel)
//    }
//
//    private var image: some View {
//        Group {
//            if loader.image != nil {
//                Image(uiImage: loader.image!)
//                    .resizable()
//            } else {
//                placeholder
//            }
//        }
//    }
//}

struct ImageView: View {
    @ObservedObject var imageFetcher: ImageFetcher
    @State var image: UIImage = UIImage()
    
    init(withURL url:String) {
        imageFetcher = ImageFetcher(urlString: url)
    }
    
    var body: some View {
    VStack {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
    }.onReceive(imageFetcher.dataPublisher) { data in
        self.image = UIImage(data: data) ?? UIImage()
    }
  }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "")
    }
}

//
//  MovieCatalog.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 14/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import SwiftUI

struct MovieCatalog: View {
    @ObservedObject var movieManager = MovieManager()
    
    var body: some View {
        NavigationView {
            List(movieManager.results) { result in
                HStack {
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w500/" + (result.poster_path ))!,
                        placeholder: Text("Loading ...")
                    )
                        .frame(width: 150)
                        
                    Text(result.title)
                }
                .frame(height: 150)
            }
            .navigationBarTitle("Movie Catalog")
        }
            //call fetMovies on page load
            .onAppear {
                self.movieManager.fetchMovies()
        }
    }
}

struct MovieCatalog_Previews: PreviewProvider {
    static var previews: some View{
        MovieCatalog()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageFetcher
    private let placeholder: Placeholder?
    
    init(url: URL, placeholder: Placeholder? = nil) {
        loader = ImageFetcher(url: url)
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}


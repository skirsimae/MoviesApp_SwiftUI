//
//  MovieCatalog.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 14/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieCatalog: View {
    @ObservedObject var movieManager = MovieManager()
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Bold", size: 22)!]

        //Use this if NavigationBarTitle is with displayMode = .inline
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    var body: some View {
        NavigationView {
            List(movieManager.results) { result in
                NavigationLink(destination: MovieDetails(movie: result, url: "https://image.tmdb.org/t/p/w500/" + (result.poster_path), title: result.title, release_date: result.release_date, overview: result.overview)) {
                        EmptyView()
                }.frame(width: 0, height: 0)
                HStack {
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w200/" + (result.poster_path))!).resizable().frame(width: 150, height: 200)
                    Text(result.title)
                }
            }
            .navigationBarTitle(Text("Movie Catalog").font(.body), displayMode: .large)
            
        }.onAppear {
            self.movieManager.fetchMovies()
        }
    }
}


struct MovieCatalog_Previews: PreviewProvider {
    static var previews: some View{
        MovieCatalog()
    }
}


let imageUrlString = "http://cdn.playbuzz.com/cdn/38402fff-32a3-4e78-a532-41f3a54d04b9/cc513a85-8765-48a5-8481-98740cc6ccdc.jpg"

let imageUrl = URL(string: imageUrlString)!

let imageData = try! Data(contentsOf: imageUrl)

let image = UIImage(data: imageData)

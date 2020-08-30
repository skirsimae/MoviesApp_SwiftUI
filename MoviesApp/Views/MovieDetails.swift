//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 05/07/2020.
//  Copyright © 2020 Silva. All rights reserved.
//


import SwiftUI
import KingfisherSwiftUI

struct MovieDetails: View {
    @ObservedObject var movieManager = MovieManager()
    
    let movie: Results
    var url: String
    let title: String
    let release_date: String
    let overview: String
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: 150, height: 200)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        Text(title)
                            .bold()
                        Button(action: {}){
                            Text("Watch Trailer")
                                .foregroundColor(.black)
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.init(.lightGray))
                                .padding(.all, 20)
                        }
                    }.padding([.leading, .trailing], 20)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Genres")
                            .bold()
                        Text(movieManager.genres.name)
                    }.padding([.leading, .trailing], 20)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Date")
                            .bold()
                        Text(release_date)
                    }.padding([.leading, .trailing], 20)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Overview")
                            .bold()
                        Text(overview).padding(.bottom, 20)
                    }.padding([.leading, .trailing], 20)
                }.frame(alignment: .leading)
            }
        .navigationBarTitle("Movie Detail")
        .onAppear {
            self.movieManager.fetchGenre(movie: self.movie)
        }
    }
}
        
struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: Results.init(title: "Something", id: 0, poster_path: "", release_date: "", overview: ""), url: "https://image.tmdb.org/t/p/w500/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", title: "Ad Astra", release_date: "2019-09-17", overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.")
    }
}

//
//  MovieManager.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 25/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: MovieManager, movies: Movie)
}

protocol MovieInfoDelegate {
    func didUpdateGenres(_ movieManager: MovieManager, info: Info)
}

protocol MovieTrailerDelegate {
    func didFetchTrailer(_ movieManager: MovieManager, videos: Videos)
}

class MovieManager: ObservableObject {
    @Published var results = [Results]()
    @Published var genres = Genres(name: "")
    
    let key = moviesAPIKey
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let popularMoviesURL: String = "popular?api_key="
    let movieDetailsURL: String = "271110?api_key="
    var movieDelegate: MovieManagerDelegate?
    var infoDelegate: MovieInfoDelegate?
    var trailerDelegate: MovieTrailerDelegate?
    
    func fetchMovies() {
        let url = URL(string: "\(baseURL)\(popularMoviesURL)\(key)&page=1")!
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
            }
            guard let data = data else {
                fatalError("Error: missing response data")
            }

            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self.results = movies.results
                }
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
       
        //Start the task
        task.resume()
    }

    func fetchGenre(movie: Results?) {
        guard let id = movie?.id else { return }

        let url = URL(string: "\(baseURL)\(id)?api_key=\(key)&language=en-US")!
        print(url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                 fatalError("Error: \(error.localizedDescription)")
             }
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
             }
            
             guard let data = data else {
                 fatalError("Error: missing response data")
             }
            print(data)

             do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Info.self, from: data)
                var genresLabel = ""
                DispatchQueue.main.async {
                    for genre in results.genres {
                        genresLabel = (genresLabel) + "\(genre.name), "
                    }
                    //Remove last two characters (comma and space) from the string
                    genresLabel = String(genresLabel.dropLast(2))
                    self.genres.name = genresLabel
                }
             }
             catch {
                 debugPrint(error)
                 print("Error: \(error.localizedDescription)")
             }
        }
        //Start the task
        task.resume()
    }
    
    func fetchTrailer(movie: Results?) {
        guard let id = movie?.id else { return }
        
        let url = URL(string: "\(baseURL)\(id)/videos?api_key=\(key)&language=en-US")!
         let session = URLSession(configuration: .default)
         let task = session.dataTask(with: url) { data, response, error in
             if let error = error {
                  fatalError("Error: \(error.localizedDescription)")
              }
              guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                  return
              }
            print (response)
             
              guard let data = data else {
                  fatalError("Error: missing response data")
              }
             print(data)

              do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Videos.self, from: data)
                self.trailerDelegate?.didFetchTrailer(self, videos: results)
              }
              catch {
                  debugPrint(error)
                  print("Error: \(error.localizedDescription)")
              }
         }
         //Start the task
         task.resume()
        
    }
}


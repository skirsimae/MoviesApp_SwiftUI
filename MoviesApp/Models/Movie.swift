//
//  Movie.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 17/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let results: [Results]
}

struct Results: Decodable, Identifiable {
    let title: String
    let id: Int
    let poster_path: String
    let release_date: String
    let overview: String
}

struct Info: Decodable {
    let genres: [Genres]
}

struct Genres: Decodable {
    var name: String
}

struct Videos: Codable {
    let results: [Trailers]
}

struct Trailers: Codable {
    let key: String
}


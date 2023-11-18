//
//  movie.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit

struct Movie: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    

    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}

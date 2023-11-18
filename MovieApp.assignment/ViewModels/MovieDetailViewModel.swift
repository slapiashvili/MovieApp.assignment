//
//  MovieDetailViewModel.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 18.11.23.
//

import UIKit

final class MovieDetailViewModel {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        movie.title
    }
    
    var releaseDate: String {
        "Release Date: \(movie.releaseDate)"
    }
    
    var rating: String {
        "Rating: \(movie.rating)"
    }
    
    var overview: String {
        movie.overview
    }
    
    var posterURL: URL? {
        movie.posterURL
    }
}



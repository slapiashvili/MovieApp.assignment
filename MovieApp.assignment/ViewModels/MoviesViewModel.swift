//
//  MoviesViewModel.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 18.11.23.
//

import UIKit

final class MoviesViewModel {
    static let shared = MoviesViewModel()

    private let movieNetworkManager = MovieNetworkManager()

    var movies = [Movie]()
    var originalMovies = [Movie]()

    func fetchMovies() async throws -> [Movie] {
        return try await movieNetworkManager.fetchMovies(from: "movie/popular")
    }

    func fetchMovieDetails(for movieId: Int) async throws -> Movie {
        return try await movieNetworkManager.fetchMovieDetails(for: movieId)
    }
}



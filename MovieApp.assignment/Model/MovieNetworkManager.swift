//
//  NetworkManager.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit

final class MovieNetworkManager {
    static let shared = MovieNetworkManager()

    let apiKey = "d5e1c3de8a3ef453ca0aa2c1ff4fadc6"
    let baseURL = "https://api.themoviedb.org/3/"

    init() {}

    func fetchMovies(from endpoint: String) async throws -> [Movie] {
        let url = baseURL + endpoint + "?api_key=\(apiKey)&language=en-US&page=1"
        guard let urlObject = URL(string: url) else {
            throw APIError.responseProblem
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: urlObject)
            let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return moviesResponse.results
        } catch {
            throw APIError.other(error)
        }
    }

    func fetchMovieDetails(for movieId: Int) async throws -> Movie {
        let detailsEndpoint = "movie/\(movieId)"
        let url = baseURL + detailsEndpoint + "?api_key=\(apiKey)&language=en-US"

        guard let urlObject = URL(string: url) else {
            throw APIError.responseProblem
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: urlObject)
            let movieDetails = try JSONDecoder().decode(Movie.self, from: data)
            return movieDetails
        } catch {
            throw APIError.other(error)
        }
    }
}


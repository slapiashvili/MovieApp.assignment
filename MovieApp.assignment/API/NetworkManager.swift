//
//  NetworkManager.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    let apiKey = "d5e1c3de8a3ef453ca0aa2c1ff4fadc6"
    let baseURL = "https://api.themoviedb.org/3/"

    private init() {}

    func fetchMovies(from endpoint: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = baseURL + endpoint + "?api_key=\(apiKey)&language=en-US&page=1"

        guard let urlObject = URL(string: url) else {
            completion(.failure(APIError.responseProblem))
            return
        }

        let task = URLSession.shared.dataTask(with: urlObject) { (data, response, error) in
            guard error == nil else {
                completion(.failure(APIError.other(error!)))
                return
            }

            guard response != nil, let data = data else {
                completion(.failure(APIError.responseProblem))
                return
            }

            do {
                let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(APIError.decodingProblem))
            }
        }

        task.resume()
    }
    
    func fetchMovieDetails(for movieId: Int) async throws -> Movie {
        let detailsEndpoint = "movie/\(movieId)"
        let url = baseURL + detailsEndpoint + "?api_key=\(apiKey)&language=en-US"

        guard let urlObject = URL(string: url) else {
            throw APIError.responseProblem
        }

        let (data, _) = try await URLSession.shared.data(from: urlObject)

        let movieDetails = try JSONDecoder().decode(Movie.self, from: data)
        return movieDetails
    }

}



//
//  APIError.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case other(Error)
}

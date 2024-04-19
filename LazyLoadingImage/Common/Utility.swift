//
//  Utility.swift
//  LazyLoadingImage
//
//  Created by Jamal Ahamad on 18/04/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

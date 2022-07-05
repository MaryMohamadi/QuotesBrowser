//
//  NetworkError.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 21.06.22.
//

import Foundation
enum NetworkError:Error {
    case noResponse
    case invalidURL
    case decodeError
    case unknown
    case httpError(Int)
    case networkError(Error)
    
    var discription: String {
        switch self {
        case .noResponse:
            return "no response"
        case .invalidURL:
            return "URL is invalid"
            
        case .decodeError:
            return "decode response problem"
            
        case .unknown:
            return "unknown error"
        case .httpError(let num):
            return "network error \(num)"
            
        case .networkError(let error):
            return "network error \(error.localizedDescription)"
        }
        
    }
    
}

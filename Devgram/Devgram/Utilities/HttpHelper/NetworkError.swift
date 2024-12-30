//
//  NetworkError.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
enum ConnectionError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidURL
    case invalidStatusCode(statusCode: Int)
    case unknownError(error:Error)
    var customDescription: String {
        switch self {
            case .invalidData: return "Invalid data"
            case .jsonParsingFailure: return "Failed to parse JSON"
            case let .requestFailed(description): return "Request failed \(description)"
            case .invalidURL: return "Invalid URL"
            case let .invalidStatusCode(statusCode): return "Invalid Status Code \(statusCode) from server. Rate limit for calling the API is excceded."
            case let .unknownError(error): return "Rate limit for API is exceeded \(error)"
        }
    }
    
}

//
//  NetworkError.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
enum ConnectionError: Error {
    case invalidRequest
    case parsingFailure
    case requestFailed(description: String)
    case invalidURL
    case invalidStatusCode(statusCode: Int)
    case unknownError(error:Error)
    var localizedDescription: String {
        switch self {
            case .invalidRequest: return "Invalid data"
            case .parsingFailure: return "Failed to parse JSON"
            case let .requestFailed(description): return "Request failed \(description)"
            case .invalidURL: return "Invalid URL"
            case let .invalidStatusCode(statusCode): return "Received Status Code \(statusCode) from server. Make sure you provide valid details."
            case let .unknownError(error): return "A network error occurred: \(error.localizedDescription)"
        }
    }
    
}

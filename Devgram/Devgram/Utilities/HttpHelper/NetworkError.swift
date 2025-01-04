//
//  NetworkError.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
enum ConnectionError: Error {
    
    case tokenSaveFailed
    case userAlreadyExists
    case invalidCredentials
    case invalidToken
    case tokenExpired
    case invalidRequest
    case parsingFailure
    case requestFailed(description: String)
    case invalidURL
    case invalidStatusCode(statusCode: Int, responseData: Data)
    case unknownError(error:Error)
    var localizedDescription: String {
        switch self {
        case .invalidRequest: 
            return "Invalid data"
        case .parsingFailure: 
            return "Failed to parse JSON"
        case let .requestFailed(description): 
            return "Request failed \(description)"
        case .invalidURL: 
            return "Invalid URL"
        case let .unknownError(error):
            return "A network error occurred: \(error.localizedDescription)"
        case .tokenSaveFailed:
            return "Toke save failed. Please relaunch app and try again."
        case .userAlreadyExists:
            return "User already exists. Please choose different user name"
        case .invalidCredentials:
            return "Invalid input. Please check your credentials."
        case .invalidToken:
            return "Invalid tokem"
        case .tokenExpired:
            return "Token expired. Please login to continue."
        case .invalidStatusCode(let statusCode, let responseData):
            var description = "Server returned error \(statusCode). Please try again with valid input."
            do {
                if let errorResponse = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any]{
                    if let errorDescription = errorResponse["message"] as? String {
                        // FIX ME: Understand backendless error codes
                        // Show custom errors per error code istead of displaying
                        // what is coming from server.
                        description = errorDescription
                    }
                }
                return description
            } catch {
                return description
            }
        }
    }
}

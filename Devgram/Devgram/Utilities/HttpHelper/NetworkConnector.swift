//
//  NetworkConnector.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
protocol NetworkConnector {
    func loadRequest<T:Decodable>(type:T.Type, endpoint:NetworkEndPoint ) async throws -> T
    func loadRequest(endpoint:NetworkEndPoint) async throws -> Data
}

extension NetworkConnector {
    
    func loadRequest<T:Decodable>(type:T.Type, endpoint:NetworkEndPoint ) async throws -> T {
        let data = try await loadRequest(endpoint: endpoint)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch {
            throw error as? ConnectionError ?? .unknownError(error: error)
        }
    }
    
    func loadRequest(endpoint:NetworkEndPoint) async throws -> Data{
        guard let url = endpoint.url else {
            throw ConnectionError.requestFailed(description: "Invalid Endpoint")
        }
        //configure request from the endpoint
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = endpoint.method.rawValue
        if endpoint.method == .post {
            if let body = endpoint.body {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            }
        }
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ConnectionError.requestFailed(description: "Request Failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw ConnectionError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        return data
    }
}


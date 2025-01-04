//
//  NetworkConnector.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation

/**
 This protocol provides functionality to load network requests and decode the response into a specified type
 or return raw data. It abstracts the network communication layer so the implementation can be resused in generic way
 */
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
            throw error as? ConnectionError ?? ConnectionError.parsingFailure
        }
    }
    
    func loadRequest(endpoint : NetworkEndPoint) async throws -> Data{
        guard let url = endpoint.url else {
            throw ConnectionError.invalidURL
        }
        //configure request from the endpoint
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = endpoint.method.rawValue
        if endpoint.method == .post || endpoint.method == .update {
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
            //check if it is 400 error
            if httpResponse.statusCode == 400 {
                throw ConnectionError.serverReturnedError(errorData: data)
            }
            throw ConnectionError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        return data
    }
}


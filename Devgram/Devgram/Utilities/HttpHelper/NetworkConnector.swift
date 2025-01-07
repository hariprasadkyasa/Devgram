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

/**
 An extension to NetworkConnector providing default implementaion for the required methods.
 */
extension NetworkConnector {
    /**
     Asynchronously loads a request from the specified endpoint, decodes the response data into the specified type `T`.
     - Parameters:
       - type: The type that conforms to `Decodable` which the response will be decoded into.
       - endpoint: The `NetworkEndPoint` that contains details for the request (URL, method, headers, etc.).
     - Returns: The decoded object of type `T`.
     - Throws: Throws errors for connection issues, parsing failures, or invalid status codes.
     */
    func loadRequest<T:Decodable>(type:T.Type, endpoint:NetworkEndPoint ) async throws -> T {
        let data = try await loadRequest(endpoint: endpoint)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch {
            throw error as? ConnectionError ?? ConnectionError.parsingFailure
        }
    }
    
    /**
    Asynchronously loads a request from the specified endpoint and returns the response data.
    - Parameters:
     - endpoint: The `NetworkEndPoint` containing the details of the request.
     - Returns: Raw `Data` from the server's response.
    - Throws: Throws errors for invalid URL, failed request, or non-200 status codes.
     */
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
            // FIX ME: Improve to throw corresponsing error instead of generic one
            throw ConnectionError.invalidStatusCode(statusCode: httpResponse.statusCode, responseData: data)
        }
        
        return data
    }
}


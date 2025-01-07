//
//  NetworkEndPoint.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
/**
 Enum representing HTTP methods for network requests.
 */
enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case update = "PUT"
}
/**
 A protocol defining basic requirements to form an HTTP request like method, body, params etc. This can be reused in a general way as it provides a clean approach to form URLReuests.
 */
protocol NetworkEndPoint {
    /**
     The HTTP method for the request (GET, POST, DELETE, etc.)
     */
    var method: HTTPMethods { get }
    /**
     The specific path for the request, relative to the base URL.
     */
    var path: String { get }
    /**
     The base URL for the request
     */
    var baseURL: String { get }
    
    // Body & headers
    /**
     The body of the request (optional), which can be encoded to JSON
     */
    var body: Encodable? { get }
    /**
     Headers for the request, such as Content-Type or Authorization.
     */
    var headers: [String: String]? { get }
    
    // Optional query items
    var queryItems: [URLQueryItem]? { get }
    
    // Computed final URL
    var url: URL? { get }

}

extension NetworkEndPoint {
    /**
     Default common headers for the request. This is used to set standard headers like `Content-Type`.
     */
    var commonHeaders: [String: String] {
        return [
            "Content-Type": Constants.API.contentType,
        ]
    }
    /**
    construct URL with scheme, host, path, queryItems
    The result is a fully-formed URL to be used for the network request.
    */
    var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.API.urlScheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

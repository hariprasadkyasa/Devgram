//
//  AuthEndPoint.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
/**
 An enum represents various endpoints required for user authentication and user management, such as login, logout, session validation, and user profile retrieval.
 Each case in the enum corresponds to a specific endpoint, and the associated properties are used to construct the request with the necessary details.
 */
enum AuthEndPoint {
    case login(username: String, password: String)
    case logout(token:String)
    case checkUserSession(token : String)
    case getCurrentUserProfile(token : String)
    case createUser(userDetails : Encodable)
}


/**
 Extension of `AuthEndPoint` to conform to the `NetworkEndPoint` protocol.
 This extension defines how each case of `AuthEndPoint` is translated into a complete network request, including HTTP method, path, base URL, request body, headers, and query parameters.
 */
extension AuthEndPoint: NetworkEndPoint {
    /**
     The HTTP method to use for the request.
     - `.post` for creating or logging in a user.
     - `.get` for session validation, logout, and fetching user profile.
     */
    var method: HTTPMethods {
        switch self {
        case .login, .createUser:
            return .post
        case .checkUserSession, .logout, .getCurrentUserProfile:
            return .get
        }
    }
    
    /**
     The path component of the endpoint URL.
     Each case specifies its own endpoint path relative to the base URL.
     */
    var path: String {
        switch self {
        case .login:
            return "/api/users/login"
        case .logout:
            return "/api/users/logout"
        case .checkUserSession (let token):
            return "/api/users/isvalidusertoken/\(token)"
        case .getCurrentUserProfile:
            return "/api/services/UserHelper/getCurrentUser"
        case .createUser:
            return "/api/data/Users"
        }
    }
    
    /**
     The base URL for the API requests.
     All endpoints use a common base URL, which is fetched from the `Constants` file.
     */
    var baseURL: String {
        return Constants.API.baseUrl
    }
    
    /**
     The body of the HTTP request.
     - For login and createUser endpoints, this includes the necessary data for the request in JSON format.
     - Other endpoints do not have body.
     */
    var body: (any Encodable)? {
        switch self {
        case .login(username: let username, password: let password):
            return ["login": username, "password": password]
        case .createUser(userDetails: let details):
            return details
        case .checkUserSession, .getCurrentUserProfile, .logout:
            return nil
        }
    }
    
    /**
     The headers for the HTTP request.
     - Adds common headers for all requests.
     - Adds a `user-token` header for endpoints that require authentication.
     */
    var headers: [String : String]? {
        switch self {
        case .login, .createUser:
            return commonHeaders
        case .checkUserSession(token : let token), .logout(token : let token), .getCurrentUserProfile(token : let token):
            var headers = commonHeaders
            headers["user-token"] = token
            return headers
        }
    }
    /**
     Query parameters for the request.
     The Authentication related endpoints not use query parameters, so returning nil.
     */
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    
}

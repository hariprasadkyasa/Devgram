//
//  AuthEndPoint.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation

enum AuthEndPoint {
    case login(username: String, password: String)
    case logout(token:String)
    case checkUserSession(token : String)
    case getCurrentUserProfile(token : String)
    case createUser(userDetails : Encodable)
}

extension AuthEndPoint: NetworkEndPoint {
    var method: HTTPMethods {
        switch self {
        case .login, .createUser:
            return .post
        case .checkUserSession, .logout, .getCurrentUserProfile:
            return .get
        }
    }
    
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
    
    var baseURL: String {
        return Constants.API.baseUrl
    }
    
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
    
    var headers: [String : String]? {
        switch self {
        case .login, .createUser:
            return commonHeaders
        case .checkUserSession(token : let token), .logout(token : let token), .getCurrentUserProfile(token : let token):
            return ["user-token": token, "Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    
}

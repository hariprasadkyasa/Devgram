//
//  AuthService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation

enum AuthError: Error {
    case tokenSaveFailed
    case userAlreadyExists
    case invalidCredentials
    case invalidToken
    case tokenExpired
    case invalidResponseCode(Int)
    case invalidResponse
}

class AuthService {
    
    func createUser(userDetails : [String : String]) async throws -> User{
        let urlString = "https://eminentnose-us.backendless.app/api/data/Users"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(userDetails)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {throw AuthError.invalidResponse}
        guard httpResponse.statusCode == 200 else {throw AuthError.invalidResponseCode(httpResponse.statusCode)}
        
        let newUser = try JSONDecoder().decode(User.self, from: data)
        return newUser
    }
    
    func loginUser(username: String = "hariprasad", password: String = "hariprasad") async throws -> User?{
        let urlString = "https://eminentnose-us.backendless.app/api/users/login"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = ["login": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {return nil}
        guard httpResponse.statusCode == 200 else {return nil}
        let user = try JSONDecoder().decode(User.self, from: data)
        //save auth token fpr further use
        if let token = user.token{
            if KeychainStorage.save(key: "authToken", value: token)
            {
                return user
            }
        }
        return nil
    }
    
    
}


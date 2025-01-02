//
//  AuthService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
class AuthenticationServiceManager: NetworkConnector, AuthenticationService{
    func createUser(userDetails : Encodable) async throws -> User{
        return try await loadRequest(type: User.self, endpoint: AuthEndPoint.createUser(userDetails: userDetails))
        
    }
    func loginUser(username: String, password: String) async throws -> User?{
        let user = try await loadRequest(type: User.self, endpoint: AuthEndPoint.login(username: username, password: password))
        //save auth token for further use
        if let token = user.token{
            if KeychainStorage.save(key: Constants.Keys.userTokenKey, value: token)
            {
                return user
            }
        }
        return nil
    }
    
    func isUserSessionValid() async throws -> Bool{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey) {
            return try await loadRequest(type: Bool.self, endpoint: AuthEndPoint.checkUserSession(token: token))
        }
        return false
    }
    
    func getCurrentUserProfile() async throws -> User{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey) {
            let user = try await loadRequest(type: User.self, endpoint: AuthEndPoint.getCurrentUserProfile(token: token))
            return user
        }else{
            throw AuthError.invalidToken
        }
    }
    
    func logout() async throws -> Bool{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey) {
            _ = try await loadRequest(endpoint: AuthEndPoint.logout(token: token))
            _ = KeychainStorage.delete(key: Constants.Keys.userTokenKey)
        }
        return true
    }
}


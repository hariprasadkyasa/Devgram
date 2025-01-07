//
//  AuthService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
/**
 This class conforms to both `NetworkConnector` and `AuthenticationService` protocols,
 It is responsible for handling network requests related to user authentication and session management like create users, log in, validate sessions, fetch user profiles, and log out.
 It also securely stores the user's token using the `KeychainStorage`.
 */
class AuthenticationServiceManager: NetworkConnector, AuthenticationService{
    func createUser(userDetails : Encodable) async throws -> User{
        return try await loadRequest(type: User.self, endpoint: AuthEndPoint.createUser(userDetails: userDetails))
        
    }
        
    /**
     This method sends a login request to the server and securely saves the authentication token in the Keychain.
     - Parameters:
       - username: The username to be used for authentication.
       - password: The password of the user.
     - Returns: A `User` object if login is successful, or `nil` if there is a problem loading request or saving usertoken.
     - Throws: Throws an error if the network request fails or the server returns an error.
     */
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
    
    /**
     This method validates the user's session by sending a request to the server with the token stored in the Keychain.
     - Returns: `true` if the session is valid, otherwise `false`.
     - Throws: Throws an error if the network request fails or the server returns an error.
     */
    func isUserSessionValid() async throws -> Bool{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey) {
            return try await loadRequest(type: Bool.self, endpoint: AuthEndPoint.checkUserSession(token: token))
        }
        return false
    }
    /**
     This method retrieves the user's profile details from the server using the authentication token stored in the Keychain.
     - Returns: A `User` object representing the current user.
     - Throws: Throws an error if the token is invalid, the network request fails, or the server returns an error.
     */
    func getCurrentUserProfile() async throws -> User{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey) {
            let user = try await loadRequest(type: User.self, endpoint: AuthEndPoint.getCurrentUserProfile(token: token))
            return user
        }else{
            throw ConnectionError.invalidToken
        }
    }
    
    /**
     This method sends a logout request to the server and removes the user token from the Keychain.
     - Returns: `true` if logout is successful.
     - Throws: Throws an error if the token is invalid, the network request fails, or the server returns an error.
     */
    func logout() async throws -> Bool{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey) {
            _ = try await loadRequest(endpoint: AuthEndPoint.logout(token: token))
            _ = KeychainStorage.delete(key: Constants.Keys.userTokenKey)
        }else{
            throw ConnectionError.invalidToken
        }
        return true
    }
}


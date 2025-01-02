//
//  MockAuthenticationService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//

import Foundation
class MockAuthenticationService: AuthenticationService {
    
    let mockUser : User
    var isAuthenticated = false
    init(mockUser : User?){
        self.mockUser = mockUser ?? User(userId: 1, name: "Test User", email: "test@abc.com")
    }
    
    func createUser(userDetails : Encodable) async throws -> User{
        //check if the provided details are not empty and create new user
        if let details = userDetails as? [String:Encodable]{
            let username = details["name"] as? String
            let email = details["email"] as? String
            //if email is 'abusive@xyz.com' throw error for testing
            if email == "abusive@xyz.com"{
                throw ConnectionError.invalidCredentials
            }
            let user = User(userId: 0, name: username!, email: email!)
            return user
        }
        throw ConnectionError.invalidCredentials
    }
    
    func loginUser(username: String, password: String) async throws -> User?{
        //if user name is same as mock username retun success
        if username == mockUser.name && !password.isEmpty{
            isAuthenticated = true
            return mockUser
        }
        throw ConnectionError.invalidCredentials
    }
    
    func isUserSessionValid() async throws -> Bool{
        return isAuthenticated
    }
    
    func getCurrentUserProfile() async throws -> User
    {
        if isAuthenticated{
            return mockUser
        }
        throw ConnectionError.invalidToken
    }
    
    func logout() async throws -> Bool{
        isAuthenticated = false
        return true
    }
}
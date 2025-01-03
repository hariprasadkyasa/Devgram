//
//  AuthenticationService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation

/**
 A protocol that defines the core authentication services required for managing user authetication and session.
 */
protocol AuthenticationService{
    func createUser(userDetails : Encodable) async throws -> User
    func loginUser(username: String, password: String) async throws -> User?
    func isUserSessionValid() async throws -> Bool
    func getCurrentUserProfile() async throws -> User
    func logout() async throws -> Bool
}

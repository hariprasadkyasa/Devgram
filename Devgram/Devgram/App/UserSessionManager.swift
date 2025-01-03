//
//  UserSessionManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//

import Foundation
/**
A protocol that defines the responsibilities for managing a user's session in the application.
Provides methods to check authentication status, retrieve the current user's details,
and handle user logout. It can be implemented to manage session-related operations across the app.
 */
protocol UserSessionManager{
    func isAuthneticated () -> Bool
    func getCurrentUser () -> User?
    func logout() async
}

//
//  UserSessionManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//

import Foundation

protocol UserSessionManager{
    func isAuthneticated () -> Bool
    func getCurrentUser () -> User?
    func logout() async
}

//
//  ProfileViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
class ProfileViewModel: ObservableObject {
    private let authenticationService = AuthenticationServiceManager()
    @Published var currentUser : User?
    
    
    
    
}

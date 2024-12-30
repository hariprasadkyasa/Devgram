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
    @MainActor
    func getUserProfile() async{
        do{
            self.currentUser = try await authenticationService.getCurrentUserProfile()
        }
        catch{
            print("Error while getting user profile: \(error)")
        }
    }
    
    @MainActor
    func logout() async -> Bool{
        do{
            let result = try await authenticationService.logout()
            if result{
                self.currentUser = nil
                return true
            }
            
        }
        catch{
            print("Error while logging out: \(error)")
        }
        return false
    }
    
    
    
}

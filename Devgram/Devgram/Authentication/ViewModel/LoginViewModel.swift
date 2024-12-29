//
//  LoginViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var userAuthenticated = false
    private var authService = AuthService()
    
    
    @MainActor
    func login() async{
        do{
            if let user = try await authService.loginUser(username: "", password: ""){
                userAuthenticated = true
            }
            
        }catch
        {
            print("The error while login:", error.localizedDescription)
        }
        
    }
}

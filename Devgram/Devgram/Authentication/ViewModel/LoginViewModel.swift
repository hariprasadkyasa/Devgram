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
    @Published var gettingUserAuthenticationStatus = false
    private var authService = AuthenticationServiceManager()
    
    
    @MainActor
    func login() async{
        do{
            if (try await authService.loginUser(username: username, password: password)) != nil{
                userAuthenticated = true
            }
            
        }catch
        {
            print("The error while login:", error.localizedDescription)
        }
        
    }
    
    @MainActor
    func checkIfUserAuthenticated() async{
        do{
            gettingUserAuthenticationStatus = true
            userAuthenticated = try await authService.isUserSessionValid()
            print("The authentication status: \(userAuthenticated)")
        }
        catch
        {
            print("The error while login:", error.localizedDescription)
        }
        gettingUserAuthenticationStatus = false
    }
}

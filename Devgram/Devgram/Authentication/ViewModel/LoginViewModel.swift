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
    @Published var authenticationInProgress = false
    @Published var gettingUserAuthenticationStatus = false
    private var authService : AuthenticationService
    @Published var currentUser : User?
    
    init(authService: AuthenticationService){
        self.authService = authService
    }
    
    @MainActor
    func login() async{
        do{
            authenticationInProgress = true
            if let user = try await authService.loginUser(username: username, password: password){
                currentUser = user
                userAuthenticated = true
                username = ""
                password = ""
                print("The current user data \(user)")
            }
            authenticationInProgress = false
        }catch {
            print("The error while login:", error.localizedDescription)
        }
        
    }
    
    @MainActor
    func checkIfUserAuthenticated() async{
        do{
            gettingUserAuthenticationStatus = true
            if try await authService.isUserSessionValid(){
                await getUserProfile()
                userAuthenticated = true
            }
            print("The authentication status: \(userAuthenticated)")
        }
        catch{
            print("The error while login:", error.localizedDescription)
        }
        gettingUserAuthenticationStatus = false
    }
    
    @MainActor
    func getUserProfile() async{
        do{
            self.currentUser = try await authService.getCurrentUserProfile()
        }
        catch{
            print("Error while getting user profile: \(error)")
        }
    }
}

extension LoginViewModel : UserSessionManager{
    func isAuthneticated() -> Bool {
        return userAuthenticated
    }
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    @MainActor
    func logout() async{
        do{
            let result = try await authService.logout()
            if result{
                self.currentUser = nil
                self.userAuthenticated = false
            }
        }
        catch{
            print("Error while logging out: \(error)")
        }
    }
    
}

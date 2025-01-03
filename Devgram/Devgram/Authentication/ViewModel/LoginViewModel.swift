//
//  LoginViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation

class LoginViewModel : BaseViewModel {
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
    
    /**
     Performs login operation with the user entered details
     Displays error updating the base class property in case of any exception from service
     */
    @MainActor
    func login() async{
        do{
            authenticationInProgress = true
            if let user = try await authService.loginUser(username: username, password: password){
                currentUser = user
                userAuthenticated = true
                username = ""
                password = ""
            }
        }catch {
            print("The error while login:", error.localizedDescription)
            displayError(error: error, heading: Constants.ErrorMessages.signInErrorHeading)
        }
        authenticationInProgress = false
        
    }
    
    /**
     Checks if the user has already logged in and there is an active session available.
     Gets the user profile if session is still active.
     Displays error updating the base class property in case of any exception from service
     */
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
            print("The error while checking user session:", error.localizedDescription)
            displayError(error: error, heading: Constants.ErrorMessages.errorGettingAuthStatusHeading)
        }
        gettingUserAuthenticationStatus = false
    }
    /**
     Gets the current user profile
     */
    @MainActor
    func getUserProfile() async{
        do{
            self.currentUser = try await authService.getCurrentUserProfile()
        }
        catch{
            print("Error while getting user profile: \(error)")
            displayError(error: error, heading: Constants.ErrorMessages.signInErrorHeading)
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
    
    /**
     Logsout the current user, causes the UI to navigate back
     */
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
            displayError(error: error, heading: Constants.ErrorMessages.signOutErrorHeading)
        }
    }
    
}

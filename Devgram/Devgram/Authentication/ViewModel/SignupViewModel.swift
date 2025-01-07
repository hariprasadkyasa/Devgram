//
//  SignupViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
/**
 A subclass of `BaseViewModel` to handle bussiness logic of user signup functionality.
 An instance of this calsss is used by `SignupView` and refreshes UI based on state changes.
 */
class SignupViewModel: BaseViewModel {
    //MARK: Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService){
        self.authService = authService
    }
    /**
     Creates a new user if the provided details are valid else displays an error to the user.
     Automatically logs in the user after successful registartion.
     - Returns:
        A User object if the registartion is successful or nil
     */
    @MainActor
    func signup() async -> User?{
        guard !username.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !email.isEmpty && password == confirmPassword else {
            messageToDisplay = Message(heading:Constants.ErrorMessages.invalidSignupDetailsHeading, message:Constants.ErrorMessages.invalidSignupDetailsMessage )
            displayMessage = true
            return nil
        }
        do{
            isLoading = true
            _ = try await authService.createUser(userDetails: ["email":email, "name":username, "password":password])
            //registration success, sign in
            return try await authService.loginUser(username: email, password: password)
        }catch{
            print("Error signing up: \(error)")
            displayError(error: error, heading: Constants.ErrorMessages.signupErrorHeading)
        }
        isLoading = false
        return nil
    }
}

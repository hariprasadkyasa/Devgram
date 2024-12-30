//
//  SignupViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
class SignupViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    private let authService: AuthenticationServiceManager = AuthenticationServiceManager()
    @MainActor
    func signup() async -> User?{
        guard !username.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !email.isEmpty && password == confirmPassword else {
            errorMessage = "Make sure all details are correct"
            return nil
        }
        do{
            _ = try await authService.createUser(userDetails: ["email":email, "name":username, "password":password])
            //registration success, sign in
            return try await authService.loginUser(username: username, password: password)
        }catch{
            print("Error signing up: \(error)")
        }
        return nil
    }
}

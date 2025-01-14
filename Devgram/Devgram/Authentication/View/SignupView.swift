//
//  SignupView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI
/**
 A view that provides interface to provide user details to create new user on the backend.
 */
struct SignupView: View {
    @ObservedObject var viewModel : SignupViewModel
    var signUpCompletion : ((User?) -> Void)
     
    /**
     Initializes the `SignupView` with the required dependencies and a completihandler to be invoked upon successful signup.
     - Parameters:
       - authService: The `AuthenticationService` instance used to handle signup operation.
       - signUpCompletion: A closure that is executed on successful completion of signup process. The User object is sent as parameter in to the closure.
     */
    init(authService: AuthenticationService, signUpCompletion : @escaping ((User?) -> Void)) {
        _viewModel = .init(wrappedValue: SignupViewModel(authService: authService))
        self.signUpCompletion = signUpCompletion
    }
    
    //MARK: View body
    var body: some View {
        VStack{
            Text(Constants.Labels.ProvideSignupDetailsMessage)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            TextField("Name", text: $viewModel.username)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .disableAutocorrection(true)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            SecureField("Confirm password", text: $viewModel.confirmPassword)
                .disableAutocorrection(true)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            Spacer()
                .frame(height: 30)
            Button {
                Task{
                    if let user = await viewModel.signup(){
                        //user created and authenticated
                        await MainActor.run(){
                            signUpCompletion(user)
                        }
                    }
                }
                
            } label: {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }.disabled(
                viewModel.username.isEmpty ||
                viewModel.email.isEmpty ||
                viewModel.password.isEmpty || viewModel.confirmPassword.isEmpty
            )
        }.padding()
            .overlay {
                if viewModel.isLoading{
                    OverlayMessageView(message: "Registering...", showProgress: true)
                }
            }
            .alert(viewModel.messageToDisplay.heading, isPresented: $viewModel.displayMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.messageToDisplay.message)
            }
    }
}


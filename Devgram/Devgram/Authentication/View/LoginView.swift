//
//  LoginView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel : LoginViewModel
    @State var postsService : PostsService
    @State var authService : AuthenticationService
    @State var displaySignUpView : Bool = false
    @State var autoLoginEnabled : Bool
    
    init(authService: AuthenticationService, postsService: PostsService, autoLoginEnabled: Bool) {
        _viewModel = .init(wrappedValue: LoginViewModel(authService: authService))
        _postsService = .init(wrappedValue: postsService)
        _authService = .init(wrappedValue: authService)
        _autoLoginEnabled = .init(wrappedValue: autoLoginEnabled)
    }
    var body: some View {
        NavigationView {
            VStack{
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                if autoLoginEnabled && viewModel.gettingUserAuthenticationStatus {
                    ProgressView()
                }else{
                    // Email Field
                    TextField("Email", text: $viewModel.username)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        
                    SecureField("Password", text: $viewModel.password)
                                    .padding()
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(10)
                    Spacer()
                        .frame(height: 20)
                    Button {
                        Task{
                            await viewModel.login()
                        }
                        
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .accessibilityIdentifier("Login_Button")
                            
                    }.disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
                    
                    HStack{
                        Text("New user?")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Button {
                            //display signup view in a sheet
                            displaySignUpView = true
                        } label: {
                            Text("Signup")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                // FIX ME: NavigationLink is deprecated but using NavigationStack
                // is introducing some major UI issues
                NavigationLink("", destination: MainTabView(userSessionManager: viewModel, postsService: postsService), isActive: $viewModel.userAuthenticated)
            }
            .onAppear {
                if autoLoginEnabled{
                    Task { await viewModel.checkIfUserAuthenticated() }
                }
                
            }
            .padding()
            .sheet(isPresented: $displaySignUpView) {
                SignupView(authService: authService){ user in
                    if let user{
                        viewModel.currentUser = user
                        withAnimation {
                            displaySignUpView = false
                        } completion: {
                            viewModel.userAuthenticated = true
                        }
                    }
                }
            }
            .overlay {
                if viewModel.authenticationInProgress{
                    OverlayMessageView(message: "Signing you in...", showProgress: true)
                }
            }            
            .alert(viewModel.messageToDisplay.heading, isPresented: $viewModel.displayMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.messageToDisplay.message)
            }

        }
        
    }
}


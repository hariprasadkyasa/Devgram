//
//  LoginView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @State var displaySignUpView : Bool = false
    var body: some View {
        NavigationView {
            VStack{
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                if loginViewModel.gettingUserAuthenticationStatus {
                    ProgressView()
                }else{
                    // Email Field
                    TextField("Email", text: $loginViewModel.username)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        
                    SecureField("Password", text: $loginViewModel.password)
                                    .padding()
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(10)
                    Spacer()
                        .frame(height: 20)
                    Button {
                        Task{
                            await loginViewModel.login()
                        }
                        
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            
                    }.disabled(loginViewModel.username.isEmpty || loginViewModel.password.isEmpty)
                    
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
                
                NavigationLink("", destination: MainTabView(userSessionManager: loginViewModel), isActive: $loginViewModel.userAuthenticated)
            }
            .onAppear {
                Task { await loginViewModel.checkIfUserAuthenticated() }
            }
            .padding()
            .sheet(isPresented: $displaySignUpView) {
                SignupView(isPresented: $displaySignUpView, userAuthenticated: $loginViewModel.userAuthenticated)
            }
            .overlay {
                if loginViewModel.authenticationInProgress{
                    OverlayMessageView(message: "Signing you in...", showProgress: true)
                }
            }
        }
        
    }
}

#Preview {
    LoginView()
}

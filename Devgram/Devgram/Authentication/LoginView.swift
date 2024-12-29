//
//  LoginView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack{
                // Title
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
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
                
                Button {
                    //just navigate to home view for now
                    loginViewModel.userAuthenticated = true
                } label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .disabled(loginViewModel.username.isEmpty && loginViewModel.password.isEmpty)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $loginViewModel.userAuthenticated) {
                MainTabView()
            }
            
            
        }
        
    }
}

#Preview {
    LoginView()
}

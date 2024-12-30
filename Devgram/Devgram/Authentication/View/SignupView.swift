//
//  SignupView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var signupViewModel = SignupViewModel()
    @Binding var isPresented: Bool
    @Binding var userAuthenticated : Bool
    var body: some View {
        VStack{
            Text("Provide your details")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            TextField("Name", text: $signupViewModel.username)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            TextField("Email", text: $signupViewModel.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            
            SecureField("Password", text: $signupViewModel.password)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            SecureField("Confirm password", text: $signupViewModel.confirmPassword)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            Spacer()
                .frame(height: 30)
            Button {
                Task{
                    if let user = await signupViewModel.signup(){
                        //user created and authenticated
                        await MainActor.run(){
                            withAnimation {
                                isPresented = false
                            } completion: {
                                userAuthenticated = true
                            }
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
                signupViewModel.username.isEmpty ||
                signupViewModel.email.isEmpty ||
                signupViewModel.password.isEmpty || signupViewModel.confirmPassword.isEmpty
            )
        }.padding()
    }
}


//
//  ProfileView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var loginViewModel : LoginViewModel
    var body: some View {
        VStack{
            if let user = loginViewModel.currentUser{
                VStack{
                    HStack{
                        Text(user.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    Button {
                        Task{
                            await loginViewModel.logout()
                        }
                    } label: {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                
            }else{
                ProgressView {
                    Text("Loading...")
                }
            }
            
        }.onAppear{
            Task {
                await loginViewModel.getUserProfile()
            }
        }
    }
}

#Preview {
    ProfileView()
}

//
//  ProfileView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            if let user = profileViewModel.currentUser{
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
                            if await profileViewModel.logout(){
                                presentation.wrappedValue.dismiss()
                            }
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
                await profileViewModel.getUserProfile()
            }
        }
    }
}

#Preview {
    ProfileView()
}

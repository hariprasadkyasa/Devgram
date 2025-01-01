//
//  ProfileHeaderView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 01/01/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var showEditProfile = false
    @EnvironmentObject var viewModel: PostGridViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 10) {
                // pic
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .foregroundColor(Color(.systemGray4))
                .padding(.horizontal)
                VStack(alignment: .leading){
                    if let user = loginViewModel.currentUser {
                        Text(user.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(user.email)
                            .font(.footnote)
                            .fontWeight(.light)
                        Button {
                            Task {
                                await loginViewModel.logout()
                            }
                            
                        } label: {
                            Text("Logout")
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .padding(5)
                                .frame(width: 100)
                                .border(Color.red, width: 0.5)
                        }

                    }
                }
                
            }
            Divider()
        }
    }
}

#Preview {
    ProfileHeaderView()
}

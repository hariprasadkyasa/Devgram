//
//  ProfileHeaderView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 01/01/25.
//

import SwiftUI
/**
A view that displays the profile header for the current user, including their profile picture, name, email, and a logout button.
This view is part of the user profile view , and it fetches user information from the `UserSessionManager` to display in UI.
 */
struct ProfileHeaderView: View {
    @State var userSessionManager: UserSessionManager
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
                    if let user = userSessionManager.getCurrentUser() {
                        Text(user.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(user.email)
                            .font(.footnote)
                            .fontWeight(.light)
                        Button {
                            Task {
                                await userSessionManager.logout()
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


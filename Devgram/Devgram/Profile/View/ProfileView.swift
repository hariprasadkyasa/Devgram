//
//  ProfileView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: PostGridViewModel = PostGridViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel


    var body: some View {
        VStack{
            ScrollView {
                // header
                ProfileHeaderView()
                // post grid view
                if viewModel.fetchingData{
                    ProgressView("Loading data...")
                }else if viewModel.postsCount == 0{
                    Text("You have not posted anything yet!")
                }
                PostGridView(posts: viewModel.posts)
                
            }.padding(.vertical)
            .refreshable {
                getPosts()
            }
            .environmentObject(viewModel)
            .onAppear {
                print("On appear of Profile")
                if !viewModel.fetchingData{
                    getPosts()
                }
                
            }
        }.navigationBarTitle("Profile")
        
    }
    
    func getPosts(){
        Task {
            if let currentUser = loginViewModel.currentUser {
                try await viewModel.fetchUserPosts(userId: currentUser.userId)
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(LoginViewModel())
}

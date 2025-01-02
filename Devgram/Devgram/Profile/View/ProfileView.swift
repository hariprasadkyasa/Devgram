//
//  ProfileView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @State var userSessionManager: UserSessionManager
    
    init(userSessionManager: UserSessionManager) {
        _viewModel = .init(wrappedValue: ProfileViewModel(postsService: PostsServiceManager()))
        _userSessionManager = .init(wrappedValue: userSessionManager)
    }
    
    var body: some View {
        VStack{
            ScrollView {
                // header
                ProfileHeaderView(userSessionManager: userSessionManager)
                    .environmentObject(viewModel)
                // post grid view
                PostGridView(posts: viewModel.posts)
                    .environmentObject(viewModel)
                if viewModel.fetchingData{
                    ProgressView()
                }else if viewModel.postsCount == 0{
                    Text("You have not posted anything yet!")
                }
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
            if let currentUser = userSessionManager.getCurrentUser() {
                try await viewModel.fetchUserPosts(userId: currentUser.userId)
            }
        }
    }
}

#Preview {
    ProfileView(userSessionManager : LoginViewModel())
}

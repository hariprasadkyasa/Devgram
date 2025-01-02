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
    
    init(userSessionManager: UserSessionManager, postsService: PostsService) {
        _viewModel = .init(wrappedValue: ProfileViewModel(postsService: postsService))
        _userSessionManager = .init(wrappedValue: userSessionManager)
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
    ]
    var imageDimension = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        VStack{
            ScrollView {
                // header
                ProfileHeaderView(userSessionManager: userSessionManager)
                    .environmentObject(viewModel)
                // post grid view
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach(0..<viewModel.posts.count, id: \.self){ index in
                        let post = viewModel.posts[index]
                        PostContentView(post: post, displayMode: .displayModeProfile)
                            .onAppear{
                                if index == viewModel.posts.count - 1{
                                    if !viewModel.isLoading{
                                        if let currentUser = userSessionManager.getCurrentUser(){
                                            Task{ await viewModel.fetchNextPosts(userId: currentUser.userId) }
                                        }
                                    }
                                }
                            }
                    }
                }
                if viewModel.isLoading{
                    ProgressView()
                }else if viewModel.postsCount == 0{
                    Text(viewModel.noPostsMessage)
                }
            }.padding(.vertical)
            .refreshable {
                getPosts()
            }
            .environmentObject(viewModel)
            .onAppear {
                if !viewModel.isLoading{
                    getPosts()
                }
                
            }
        }
        .alert(viewModel.messageToDisplay.heading, isPresented: $viewModel.displayMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.messageToDisplay.message)
        }
    }
    
    func getPosts(){
        Task {
            if let currentUser = userSessionManager.getCurrentUser() {
                await viewModel.fetchUserPosts(userId: currentUser.userId)
            }
        }
    }
}



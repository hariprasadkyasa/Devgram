//
//  ProfileView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var postsViewModel : PostsViewModel
    @State var userSessionManager: UserSessionManager
    
    init(userSessionManager: UserSessionManager, postsService: PostsService) {
        _userSessionManager = .init(wrappedValue: userSessionManager)
        _postsViewModel = .init(wrappedValue: PostsViewModel(postsService: postsService))
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
                // post grid view
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach(0..<postsViewModel.posts.count, id: \.self){ index in
                        let post = postsViewModel.posts[index]
                        PostContentView(post: post, displayMode: .displayModeProfile)
                            .onAppear{
                                if index == postsViewModel.posts.count - 1{
                                    if !postsViewModel.isLoading{
                                        if let currentUser = userSessionManager.getCurrentUser(){
                                            Task{ await postsViewModel.loadPosts(userId: currentUser.userId) }
                                        }
                                    }
                                }
                            }
                    }
                }
                if postsViewModel.isLoading{
                    ProgressView()
                }else if postsViewModel.postsCount == 0{
                    Text(postsViewModel.noPostsMessage)
                }
            }.padding(.vertical)
            .refreshable {
                getPosts()
            }
            .onAppear {
                print("on appear profile")
                if !postsViewModel.isLoading{
                    getPosts()
                }
                
            }
        }
        .alert(postsViewModel.messageToDisplay.heading, isPresented: $postsViewModel.displayMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(postsViewModel.messageToDisplay.message)
        }
    }
    
    func getPosts(){
        Task {
            if let currentUser = userSessionManager.getCurrentUser() {
                postsViewModel.postsPerPage = 20
                await postsViewModel.loadPosts(userId: currentUser.userId)
            }
        }
    }
}



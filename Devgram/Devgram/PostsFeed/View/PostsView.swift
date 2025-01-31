//
//  PostsView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
import SwiftUI
/**
 A view for displaying a list of posts, allowing users to like/unlike posts and load more posts by scrolling ecisting content.
 */
struct PostsView : View {
    @StateObject var viewModel: PostsViewModel
    @State var userSessionManager: UserSessionManager
    /**
     Initialize the PostsView with a user session manager and posts service.
     */
    init(userSessionManager: UserSessionManager, postsService: PostsService){
        _viewModel = .init(wrappedValue: PostsViewModel(postsService: postsService))
        _userSessionManager = .init(wrappedValue: userSessionManager)
    }
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack(spacing: 30){
                    ForEach(0..<viewModel.posts.count, id: \.self){ index in
                        let post = viewModel.posts[index]
                        if let currentUser = userSessionManager.getCurrentUser(){
                            PostCellView(post: post, liked: post.likedby.contains(currentUser.userId), likedCount: post.likedby.count){ liked in
                                //like button tapped
                                Task{
                                    await viewModel.updateLike(post: post, liked: liked, user: currentUser)
                                }
                            }
                            .onAppear{
                                if index == viewModel.posts.count - 1{
                                    Task { await viewModel.loadNextSetOfPosts()}
                                }
                            }
                            
                        }

                    }
                }
                
                if viewModel.isLoading{
                    ProgressView()
                }else if viewModel.posts.isEmpty{
                    Text(Constants.Labels.NoPostsInFeedMessage)
                }
            }.refreshable {
                Task {
                    await viewModel.loadPosts()
                }
            }
            .scrollIndicators(.hidden)
        
        }.onAppear{
            Task{
                print("On Appear called!")
                await viewModel.loadPosts()
            }
        }
        .overlay {
            if viewModel.displayOverlayMessage{
                OverlayMessageView(message: viewModel.overlayMessage, indicateError: true)
            }
        }
        .alert(viewModel.messageToDisplay.heading, isPresented: $viewModel.displayMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.messageToDisplay.message)
        }
        
    }
}





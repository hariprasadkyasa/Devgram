//
//  PostsView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
import SwiftUI

struct PostsView : View {
    @StateObject var postsViewModel: PostsViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack(spacing: 30){
                    ForEach(0..<postsViewModel.posts.count, id: \.self){ index in
                        let post = postsViewModel.posts[index]
                        if let currentUser = loginViewModel.currentUser{
                            PostCellView(post: post, liked: post.likedby.contains(currentUser.userId), likedCount: post.likedby.count){ liked in
                                //like button tapped
                                Task{
                                    let success = try await postsViewModel.updateLike(post: post, liked: liked, user: currentUser)
                                    if !success{
                                        postsViewModel.overlayMessage = "Error updating like!."
                                        postsViewModel.displayOverlayMessage = true
                                    }
                                }
                            }
                            .onAppear{
                                if index == postsViewModel.posts.count - 1{
                                    Task {try await postsViewModel.loadNextSetOfPosts()}
                                }
                            }
                            
                        }

                    }
                }
                if postsViewModel.posts.isEmpty{
                    Text("No posts to show!")
                }
                if postsViewModel.isLoadingData{
                    ProgressView()
                }
            }.refreshable {
                Task {
                    try await postsViewModel.loadPosts()
                }
            }
        
        }.onAppear{
            Task{
                do {
                    try await postsViewModel.loadPosts()
                }catch{
                    print("Some error occured retrieving posts!")
                }
                
            }
            
        }
        .overlay {
            if postsViewModel.displayOverlayMessage{
                OverlayMessageView(message: postsViewModel.overlayMessage, indicateError: true)
            }
            
        }
        
    }
}





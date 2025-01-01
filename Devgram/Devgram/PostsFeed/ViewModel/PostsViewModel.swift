//
//  PostsViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsViewModel: ObservableObject{
    private let postsService = PostsServiceManager()
    @Published var posts : [Post] = [Post]()
    @Published var displayOverlayMessage : Bool = false
    var overlayMessage : String = ""
    
    @MainActor
    func loadPosts() async throws{
        do{
            let posts = try await postsService.getPosts()
            if posts.count > 0{
                //display posts
                self.posts = posts
                print("The posts from the server are: \(posts)")
            }
        } catch {
            print("error fetching posts: ",error.localizedDescription)
        }
    }
    
    func updateLike (post: Post, liked : Bool, user:User) async throws -> Bool{
        var currentPost = post
        if liked{
            currentPost.likedby.append(user.userId)
        }else{
            currentPost.likedby.removeAll(where: { $0 == user.userId})
        }
        //post this to server
        return try await postsService.updatePost(post: currentPost)
    }
}

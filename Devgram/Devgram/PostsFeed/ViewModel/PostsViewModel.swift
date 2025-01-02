//
//  PostsViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsViewModel: ObservableObject{
    private let postsService : PostsService
    @Published var posts : [Post] = [Post]()
    @Published var displayOverlayMessage : Bool = false
    @Published var isLoadingData : Bool = false
    var overlayMessage : String = ""
    var offset : Int = 0
    
    init(postsService : PostsService){
        self.postsService = postsService
    }
    
    @MainActor
    func loadPosts() async throws{
        do{
            let posts = try await postsService.getPosts(quantity: 3,offset: offset , userId: nil)
            if posts.count > 0{
                //display posts
                self.posts = posts
                print("The posts from the server are \(posts.count): \(posts)")
            }
        } catch {
            print("error fetching posts: ",error.localizedDescription)
        }
    }
    
    @MainActor
    func loadNextSetOfPosts() async throws{
        do{
            isLoadingData = true
            offset += 3
            let posts = try await postsService.getPosts(quantity: 3,offset: offset , userId: nil)
            if posts.count > 0{
                //display posts
                self.posts.append(contentsOf: posts)
                print("The next set of posts from the server are \(posts.count), Total posts \(self.posts.count)")
            }
            isLoadingData = false
        } catch {
            print("error fetching next posts: ",error.localizedDescription)
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

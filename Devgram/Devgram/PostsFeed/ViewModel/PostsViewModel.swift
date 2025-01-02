//
//  PostsViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsViewModel: BaseViewModel{
    private let postsService : PostsService
    @Published var posts : [Post] = [Post]()
    var offset : Int = 0
    
    init(postsService : PostsService){
        self.postsService = postsService
    }
    
    @MainActor
    func loadPosts() async{
        do{
            isLoading = true
            let posts = try await postsService.getPosts(quantity: 3,offset: offset , userId: nil)
            if posts.count > 0{
                //display posts
                self.posts = posts
            }
        } catch {
            print("error fetching posts: ",error.localizedDescription)
            displayError(error: error, heading: Constants.ErrorMessages.errorFetchingPostsHeading)
            
        }
        isLoading = true
    }
    
    @MainActor
    func loadNextSetOfPosts() async {
        do{
            isLoading = true
            offset += 3
            let posts = try await postsService.getPosts(quantity: 3,offset: offset , userId: nil)
            if posts.count > 0{
                //display posts
                self.posts.append(contentsOf: posts)
            }
        } catch {
            print("error fetching next posts: ",error.localizedDescription)
            displayError(error: error, heading: Constants.ErrorMessages.errorFetchingPostsHeading)
        }
        isLoading = false
    }
    
    
    
    func updateLike (post: Post, liked : Bool, user:User) async{
        var currentPost = post
        if liked{
            currentPost.likedby.append(user.userId)
        }else{
            currentPost.likedby.removeAll(where: { $0 == user.userId})
        }
        do{
            //post this to server
            try await postsService.updatePost(post: currentPost)
        }catch {
            print("Error while updating like!", error)
            overlayMessage = Constants.ErrorMessages.errorUpdatingLikeHeading
            displayOverlayMessage = true
        }
        
        
    }
}

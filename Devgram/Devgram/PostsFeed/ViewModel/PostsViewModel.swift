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
    @Published var noPostsMessage = Constants.Labels.NoPostsInProfileMessage
    var offset : Int = 0
    public var postsPerPage : Int = 3
    
    init(postsService : PostsService){
        self.postsService = postsService
    }
    
    var postsCount: Int {
        posts.count
    }
    /**
     Retrieves the initial set of posts and trigger UI update.
     Displays an error to the user if there is any issue getting the posts.
     - Parameters;
        - userId: Optional user id to get posts of, if nil gets all posts
     */
    @MainActor
    func loadPosts(userId: Int? = nil) async{
        do{
            isLoading = true
            let posts = try await postsService.getPosts(quantity: postsPerPage,offset: 0 , userId: userId)
            if posts.count > 0{
                //display posts
                self.posts = posts
            }
        } catch {
            print("error fetching posts: ",error.localizedDescription)
            displayError(error: error, heading: Constants.ErrorMessages.errorFetchingPostsHeading)
            noPostsMessage = Constants.ErrorMessages.errorFetchingPostsHeading
        }
        isLoading = false
    }
    
    /**
     Retrieves the next set of posts as the user scrolls the posts list and trigger UI update.
     Displays an error to the user if there is any issue getting the posts.
     - Parameters;
        - userId: Optional user id to get posts of, if nil gets all posts
     */
    @MainActor
    func loadNextSetOfPosts(userId: Int? = nil) async {
        do{
            isLoading = true
            offset += postsPerPage
            let posts = try await postsService.getPosts(quantity: postsPerPage, offset: offset , userId: userId)
            if posts.count > 0{
                //display posts
                self.posts.append(contentsOf: posts)
            }
        } catch {
            print("error fetching next posts: ",error.localizedDescription)
            displayError(error: error, heading: Constants.ErrorMessages.errorFetchingPostsHeading)
            noPostsMessage = Constants.ErrorMessages.errorFetchingPostsHeading
        }
        isLoading = false
    }
    
    
    /**
     Updates a proided posts with the latest likes info when user interacted with post.
     Displays error to the user if there is any problem updating the post.
     - Parameters:
        - post: The posts object to be updated
        - liked: A Bool representing whether current user liked or unliked the post
        - user: User object representing current user.
     */
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

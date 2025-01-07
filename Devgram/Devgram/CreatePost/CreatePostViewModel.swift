//
//  CreatePostViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
/**
The `CreatePostViewModel` is a view model class responsible for managing creating posts logic and state of the `CreatePostView`.
This class inherits from `BaseViewModel` and iteracts with the `PostsService` to save the post.
 */
class CreatePostViewModel : BaseViewModel{
    private let postsService : PostsService
    @Published var postContent : String = ""
    let postTypes : [String] = [PostType.text.rawValue, PostType.code.rawValue, PostType.link.rawValue]
    
    /**
     Initialises `CreatePostViewModel` with `PostsService` as dependency
     */
    init(postsService : PostsService){
        self.postsService = postsService
    }
    /**
     Creates a new post with user provided data.
     - Parameters:
        - type: An integer representing index of element in postTypes property. Actual value will be text,code ot link
        - currentUser: The User reference representing currently logged in user.
     - Throws:
        - An error if the post can not be created because of any reason
     */
    func createPost(type : Int, for currentUser : User) async throws{
        //instantiate new Post object and send to service
        let milliSeconds = Date().timeIntervalSince1970 * 1000
        let post = Post(id: 0, username: currentUser.name, userid: currentUser.userId, content: postContent, likes: 0, posttype: postTypes[type], created: milliSeconds , updated: milliSeconds, likedby: [])
        try await postsService.createPost(post: post)
    }
    
}

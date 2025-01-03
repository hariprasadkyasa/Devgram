//
//  CreatePostViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation

class CreatePostViewModel : BaseViewModel{
    private let postsService : PostsService
    @Published var postContent : String = ""
    let postTypes : [String] = [PostType.text.rawValue, PostType.code.rawValue, PostType.link.rawValue]
    
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
        let post = Post(id: 0, username: currentUser.name, userid: currentUser.userId, content: postContent, likes: 0, posttype: postTypes[type], created: Date.timeIntervalSinceReferenceDate, updated: Date.timeIntervalSinceReferenceDate, likedby: [])
        try await postsService.createPost(post: post)
    }
    
}

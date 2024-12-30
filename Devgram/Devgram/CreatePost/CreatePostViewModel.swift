//
//  CreatePostViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation

class CreatePostViewModel : ObservableObject{
    private let postsService = PostsServiceManager()
    @Published var postContent : String = ""
    @Published var displayOverlayMessage : Bool = false
    let postTypes : [String] = [PostType.text.rawValue, PostType.code.rawValue, PostType.link.rawValue]
    
    func createPost(type : Int, for currentUser : User) async throws{
        //instantiate new Post object and send to service
        let post = Post(id: 0, username: currentUser.name, userid: currentUser.userId, content: postContent, likes: 0, posttype: postTypes[type])
        do {
            let isSuccess = try await postsService.createPost(post: post)
            if isSuccess{
                print("Post created successfully")
            }
        }catch{
            print("Error creating post \(error)")
        }
        
    }
    
}

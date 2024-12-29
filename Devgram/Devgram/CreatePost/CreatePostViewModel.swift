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
    
    func createPost() async throws{
        //instantiate new Post object and send to service
        let post = Post(postid: 0, content: postContent, user_name: "hari", user_id: 1)
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

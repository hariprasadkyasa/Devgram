//
//  PostsViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsViewModel: ObservableObject{
    private let postsService = PostsServiceManager()
    
    init(){
        Task {
            try await loadPosts()
        }
    }
    
    func loadPosts() async throws{
        do{
            let posts = try await postsService.getPosts()
            if posts.count > 0{
                //display posts
                print("The posts are: ", posts)
            }
        } catch {
            print("error fetching posts: ",error.localizedDescription)
        }
    }
}

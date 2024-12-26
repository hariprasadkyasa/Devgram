//
//  PostsViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsViewModel: ObservableObject{
    private let postsService = PostsServiceManager()
    func loadPosts(){
        postsService.getPosts { posts, error in
            if let error = error{
                //update ui to display error
                print("error fetching posts: ",error.localizedDescription)
                return
            }
            if posts.count > 0{
                //display posts
                print("The posts are: ", posts)
            }
        }
    }
}

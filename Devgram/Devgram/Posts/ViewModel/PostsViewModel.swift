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
    @MainActor
    func loadPosts() async throws{
        do{
            let posts = try await postsService.getPosts()
            if posts.count > 0{
                //display posts
                self.posts = posts
            }
        } catch {
            print("error fetching posts: ",error.localizedDescription)
        }
    }
}

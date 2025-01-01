//
//  PostGridViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 01/01/25.
//

import Foundation
class PostGridViewModel: ObservableObject {
    private let postsService = PostsServiceManager()
    @Published var posts = [Post]()
    @Published var fetchingData = false

    var postsCount: Int {
        posts.count
    }

    @MainActor
    func fetchUserPosts(userId: Int) async throws {
        do {
            fetchingData = true
            posts = try await postsService.getPosts(userId: userId)
            fetchingData = false
            print("Done fetching user posts!")
        }catch{
            print("Error fetching user posts!", error)
        }
        
    }
}

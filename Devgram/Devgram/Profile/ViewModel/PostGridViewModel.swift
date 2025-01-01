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
    var isDataFetched = false

    var postsCount: Int {
        posts.count
    }

    @MainActor
    func fetchUserPosts(userId: Int) async throws {
        if !isDataFetched {
            posts = try await postsService.getPosts(userId: userId)
            isDataFetched = true
        }
    }
}

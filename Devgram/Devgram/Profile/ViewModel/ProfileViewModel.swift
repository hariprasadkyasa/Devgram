//
//  ProfileViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 01/01/25.
//

import Foundation
class ProfileViewModel: ObservableObject {
    private let postsService : PostsService
    @Published var posts = [Post]()
    @Published var fetchingData = false

    init(postsService: PostsService) {
        self.postsService = postsService
    }
    
    var postsCount: Int {
        posts.count
    }

    @MainActor
    func fetchUserPosts(userId: Int) async throws {
        do {
            fetchingData = true
            posts = try await postsService.getPosts(quantity: 20, offset: 0, userId: userId)
            fetchingData = false
            print("Done fetching user posts!")
        }catch{
            print("Error fetching user posts!", error)
        }
    }
    
    func fetchMorePosts(userId: Int) async throws {
        do {
            fetchingData = true
            posts += try await postsService.getPosts(quantity: 20, offset: postsCount-1, userId: userId)
            fetchingData = false
            print("Done fetching more posts!")
        }catch{
            print("Error fetching more posts!", error)
        }
    }
}

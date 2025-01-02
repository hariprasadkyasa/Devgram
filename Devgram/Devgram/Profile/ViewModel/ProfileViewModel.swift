//
//  ProfileViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 01/01/25.
//

import Foundation
class ProfileViewModel: BaseViewModel {
    private let postsService : PostsService
    @Published var posts : [Post] = [Post]()
    @Published var noPostsMessage = Constants.Labels.NoPostsInProfileMessage

    init(postsService: PostsService) {
        self.postsService = postsService
    }
    
    var postsCount: Int {
        posts.count
    }

    @MainActor
    func fetchUserPosts(userId: Int) async {
        do {
            isLoading = true
            posts = try await postsService.getPosts(quantity: 20, offset: 0, userId: userId)
        }catch{
            print("Error fetching user posts!", error)
            displayError(error: error, heading: Constants.ErrorMessages.errorFetchingPostsHeading)
            noPostsMessage = Constants.ErrorMessages.errorFetchingPostsHeading
        }
        isLoading = false
    }
    @MainActor
    func fetchNextPosts(userId: Int) async {
        do {
            isLoading = true
            posts += try await postsService.getPosts(quantity: 20, offset: postsCount-1, userId: userId)
            isLoading = false
        }catch{
            print("Error fetching more posts!", error)
            displayError(error: error, heading: Constants.ErrorMessages.errorFetchingPostsHeading)
        }
    }
}

//
//  PostsService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation

/**
This protocol provides methods for retrieving posts with pagination support, creating new posts,
and updating existing posts.
 */
protocol PostsService {
    func getPosts(quantity: Int, offset: Int, userId: Int?) async throws -> [Post]
    func createPost(post: Post) async throws
    func updatePost(post: Post) async throws
}


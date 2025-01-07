//
//  PostsServiceManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
/**
A class is responsible for managing network requests related to posts.
It conforms to the `NetworkConnector` and `PostsService` protocols.
 */
class PostsServiceManager : NetworkConnector, PostsService {
    /**
     Fetches a list of posts based on the provided quantity, offset, and optional userId.
     - Parameters:
       - quantity: The number of posts to retrieve.
       - offset: The starting index for pagination.
       - userId: An optional user ID to filter posts for a specific user.
     - Returns: An array of `Post` objects.
     - Throws: An error if there is any problem retrieving the data or request fails.
     */
    func getPosts(quantity: Int, offset: Int, userId: Int?) async throws -> [Post]{
        var posts = [Post]()
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
            if let userId{
                posts = try await loadRequest(type: [Post].self, endpoint: PostsEndPoint.getUserPosts(count: quantity, index: offset, userId: userId, token: token))
            }else{
                posts = try await loadRequest(type: [Post].self, endpoint: PostsEndPoint.getPosts(count: quantity, index: offset, token: token))
            }
        }
        return posts
    }
    
         
    /**
     Creates a new post on the server.
     - Parameters:
        - post: The `Post` object containing details to create new post.
     - Throws: An error if the network request fails.
     */
    func createPost(post: Post) async throws{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
            _ = try await loadRequest(endpoint: PostsEndPoint.createPost(post: post, token: token))
        }
    }
    
    /**
     Updates an existing post using the provided `Post` object.
     - Parameters:
        - post: The `Post` object representing updated data.
     - Throws:
        - An error if the network request fails.
     */
    func updatePost(post: Post) async throws{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
            _ = try await loadRequest(endpoint: PostsEndPoint.updatePost(post: post, token: token))
        }
    }
    
}

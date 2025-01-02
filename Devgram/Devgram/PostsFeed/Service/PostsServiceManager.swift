//
//  PostsServiceManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsServiceManager : NetworkConnector, PostsService {
    
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
        
    func createPost(post: Post) async throws{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
            _ = try await loadRequest(endpoint: PostsEndPoint.createPost(post: post, token: token))
        }
    }
    
    func updatePost(post: Post) async throws{
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
            _ = try await loadRequest(endpoint: PostsEndPoint.updatePost(post: post, token: token))
        }
    }
    
}

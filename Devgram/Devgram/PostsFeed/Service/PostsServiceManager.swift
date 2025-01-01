//
//  PostsServiceManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsServiceManager : NetworkConnector, PostsService {
    
    
    func getPosts(quantity: Int = 10, offset: Int = 0) async throws -> [Post]{
        var posts = [Post]()
        if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
            posts = try await loadRequest(type: [Post].self, endpoint: PostsEndPoint.getPosts(count: quantity, index: offset, token: token))
        }
        return posts
    }
    
//    func getPosts(quantity: Int = 10, offset: Int = 0) async throws -> [Post]{
//        return [
//            Post(id: 0, username: "Hariprasad", userid: 0, content: "let testInstance = Test()\ntestInstance.testMethod()\nprint(testInstance.testProperty)\ntestInstance.testMethod()\ntestInstance.testMethod()\ntestInstance.testMethod()\ntestInstance.testMethod()", likes: 0, posttype: "code"),
//            Post(id: 1, username: "Hari", userid: 1, content: "let testInstance = Test()\ntestInstance.testMethod()\nprint(testInstance.testProperty)\ntestInstance.testMethod()\ntestInstance.testMethod()\ntestInstance.testMethod()\ntestInstance.testMethod()", likes: 0, posttype: "code"),
//            Post(id: 2, username: "Raghu", userid: 2, content: "Normal text post", likes: 0, posttype: "text"),
//            Post(id: 3, username: "Prasad", userid: 3, content: "www.developer.apple.com", likes: 0, posttype: "link"),
//        ]
//    }
    
    func createPost(post: Post) async throws -> Bool{
        do {
            if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
                _ = try await loadRequest(endpoint: PostsEndPoint.createPost(post: post, token: token))
            }
        }catch{
            return false
        }
        return true
    }
    
    func updatePost(post: Post) async throws -> Bool{
        do {
            if let token = KeychainStorage.retrieve(key: Constants.Keys.userTokenKey){
                _ = try await loadRequest(endpoint: PostsEndPoint.updatePost(post: post, token: token))
            }
        }catch{
            return false
        }
        return true
    }
    
}

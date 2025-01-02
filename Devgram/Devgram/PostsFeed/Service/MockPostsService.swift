//
//  MockPostsService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import Foundation
class MockPostsService: PostsService {
    
    var mockPosts : [Post]
    var simulateError : Bool = false
    init(mockPosts: [Post]?) {
        self.mockPosts = mockPosts ?? [Post(id: 1, username: "test user1", userid: 1, content: "test content", likes: 0, posttype: "text", created: Date().timeIntervalSinceReferenceDate, updated: Date().timeIntervalSinceReferenceDate, likedby: []),Post(id: 2, username: "test user1", userid: 1, content: "test content", likes: 0, posttype: "text", created: Date().timeIntervalSinceReferenceDate, updated: Date().timeIntervalSinceReferenceDate, likedby: []), Post(id: 3, username: "test user1", userid: 1, content: "test content", likes: 0, posttype: "text", created: Date().timeIntervalSinceReferenceDate, updated: Date().timeIntervalSinceReferenceDate, likedby: []), Post(id: 4, username: "test user1", userid: 1, content: "test content", likes: 0, posttype: "text", created: Date().timeIntervalSinceReferenceDate, updated: Date().timeIntervalSinceReferenceDate, likedby: [])
                                       
        ]
    }
    
    func getPosts(quantity: Int, offset: Int, userId: Int?) async throws -> [Post] {
        if simulateError {
            throw ConnectionError.invalidRequest
        }
        return mockPosts
    }
    
    func createPost(post: Post) async throws {
        //throw error if user id is zero on post for testing
        if post.userid == 0 {
            throw ConnectionError.invalidRequest
        }
    }
    
    func updatePost(post: Post) async throws {
        //throw error if post doesnt have object id for testing
        if post.objectId == nil {
            throw ConnectionError.invalidRequest
        }
    }
    
    
}

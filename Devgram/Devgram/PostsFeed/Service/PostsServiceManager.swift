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
    
    
//    func getPosts(quantity: Int = 10, offset: Int = 0) async throws -> [Post]{
//        let postsURLString = "https://eminentnose-us.backendless.app/api/data/Posts?pageSize=\(quantity)&offset=\(offset)&sortBy=created"
//        guard let postsURL = URL(string: postsURLString) else {return []}
//        
//        let (responseData, httpResponse) = try await URLSession.shared.data(from: postsURL)
//        guard (httpResponse as? HTTPURLResponse)?.statusCode == 200 else {return []}
//        let posts = try JSONDecoder().decode([Post].self, from: responseData)
//        return posts
//    }
    
//    func getPosts(quantity: Int = 10, offset: Int = 0) async throws -> [Post]{
//        return [
//            Post(postid: 1, content: "let testInstance = Test()\ntestInstance.testMethod()\nprint(testInstance.testProperty)\ntestInstance.testMethod()\ntestInstance.testMethod()\ntestInstance.testMethod()\ntestInstance.testMethod()", user_name: "Hari"),
//            Post(postid: 2, content: "Sample post 2", user_name: "Hari prasad"),
//            Post(postid: 3, content: "Sample post 3", user_name: "Raghavendra"),
//            Post(postid: 4, content: "Sample post 4", user_name: "Prasad"),
//            Post(postid: 5, content: "Sample post 5", user_name: "Raghu"),
//        ]
//    }
    
//    func createPost(post: Post) async throws -> Bool{
//        let postData = try JSONEncoder().encode(post)
//        let postURLString = "https://eminentnose-us.backendless.app/api/data/Posts"
//        guard let postURL = URL(string: postURLString) else {return false}
//        var request = URLRequest(url: postURL)
//        request.httpMethod = "POST"
//        request.httpBody = postData
//        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
//        let (_, response) = try await URLSession.shared.data(for: request)
//        let httpResponse = response as? HTTPURLResponse
//        guard (httpResponse)?.statusCode == 200 else {return false}
//        return true
//    }
    
    
}

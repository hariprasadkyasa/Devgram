//
//  PostsServiceManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsServiceManager {
//    func getPosts(quantity: Int = 10, offset: Int = 0) async throws -> [Post]{
//        let postsURLString = "https://eminentnose-us.backendless.app/api/data/Posts?pageSize=\(quantity)&offset=\(offset)&sortBy=created"
//        guard let postsURL = URL(string: postsURLString) else {return []}
//        let (responseData, httpResponse) = try await URLSession.shared.data(from: postsURL)
//        guard (httpResponse as? HTTPURLResponse)?.statusCode == 200 else {return []}
//        let posts = try JSONDecoder().decode([Post].self, from: responseData)
//        return posts
//    }
    
    func getPosts(quantity: Int = 10, offset: Int = 0) async throws -> [Post]{
        return [
            Post(postid: 1, content: "Sample post 1", user_name: "Hari"),
            Post(postid: 2, content: "Sample post 2", user_name: "Hari prasad"),
            Post(postid: 3, content: "Sample post 3", user_name: "Raghavendra"),
            Post(postid: 4, content: "Sample post 4", user_name: "Prasad"),
            Post(postid: 5, content: "Sample post 5", user_name: "Raghu"),
        ]
    }
    
    
}

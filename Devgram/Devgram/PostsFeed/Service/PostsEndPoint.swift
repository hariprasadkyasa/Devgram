//
//  PostsEndPoint.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
/**
`PostsEndPoint` is an enumeration representing the various API endpoints for managing posts in the application.
This enum conforms to `NetworkEndPoint` so it can be used to send posts relates requests to server.
Supported Endpoints:
 - `getPosts`: Fetches a list of posts with pagination.
 - `createPost`: Creates a new post with the provided data.
 - `updatePost`: Updates an existing post using its unique identifier (object ID).
 - `getUserPosts`: Fetches posts specific to a user with pagination.
 */
enum PostsEndPoint {
    case getPosts(count:Int, index:Int, token:String)
    case createPost(post:Post, token:String)
    case updatePost(post:Post, token:String)
    case getUserPosts(count:Int, index:Int,userId:Int, token:String)
    
}


/**
 An extention of `PostsEndPoint` confirming to `NetworkEndPoint`
 */
extension PostsEndPoint: NetworkEndPoint {
    /**
     Specifies the HTTP method for each endpoint.
     */
    var method: HTTPMethods {
        switch self{
        case .getPosts, .getUserPosts: return .get
        case .createPost: return .post
        case .updatePost: return .update
        }
    }
    /**
     Provides the path for each request.
     For `updatePost`, the path includes the object ID of the post being updated.
     */
    var path: String {
        switch self{
        case .getPosts, .createPost, .getUserPosts:
            return "/api/data/Posts"
        case .updatePost(post:let post, token: _):
            if let objectID = post.objectId{
                return "/api/data/Posts/\(objectID)"
            }
            return "/api/data/Posts"
        }
    }
    /**
     Specifies the base URL for all endpoints.
     */
    var baseURL: String {
        return Constants.API.baseUrl
    }
    
    /**
     Defines the body content for HTTP requests.
     - For `getPosts` and `getUserPosts`, as the request is GET type, there will be no body.
     - For `createPost` and `updatePost`, the body contains the `Post` object.
     */
    var body: (any Encodable)? {
        switch self{
        case .getPosts, .getUserPosts:
            return nil
        case .createPost(post:let post, token: _), .updatePost(post:let post, token: _):
            return post
        }
    }
    
    /**
     Specifies the headers for each endpoint.
     - Includes the user token for authentication for applicable requests.
     */
    var headers: [String : String]? {
        switch self{
        case .getPosts, .getUserPosts:
            return commonHeaders
        case .createPost(post:_, token: let token), .updatePost(post:_, token: let token):
            var headers = commonHeaders
            headers["user-token"] = token
            return headers
        }
    }
    
    /**
     Specifies the query parameters for each endpoint.
     - Includes pagination parameters for `getPosts` and `getUserPosts`.
     */
    var queryItems: [URLQueryItem]? {
        switch self{
        case .getPosts(count:let count, index:let index, token:_):
            return [URLQueryItem(name: "pageSize", value: String(count)), URLQueryItem(name: "offset", value: String(index)), URLQueryItem(name: "sortBy", value: "updated desc")]
        case .getUserPosts(count:let count, index:let index, userId: let userId, token:_):
            return [URLQueryItem(name: "pageSize", value: String(count)), URLQueryItem(name: "offset", value: String(index)), URLQueryItem(name: "sortBy", value: "updated desc"), URLQueryItem(name: "sortBy", value: "updated desc"), URLQueryItem(name: "where", value: "userid="+String(userId))]
        case .createPost, .updatePost:
            return nil
        }
    }
    
    
}

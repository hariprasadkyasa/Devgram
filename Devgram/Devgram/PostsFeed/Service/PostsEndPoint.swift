//
//  PostsEndPoint.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
enum PostsEndPoint {
    case getPosts(count:Int, index:Int, token:String)
    case createPost(post:Post, token:String)
    case updatePost(post:Post, token:String)
    
}

extension PostsEndPoint: NetworkEndPoint {
    var method: HTTPMethods {
        switch self{
            case .getPosts: return .get
        case .createPost: return .post
        case .updatePost: return .update
        }
    }
    
    var path: String {
        switch self{
        case .getPosts, .createPost :
            return "/api/data/Posts"
        case .updatePost(post:let post, token: _):
            if let objectID = post.objectId{
                return "/api/data/Posts/\(objectID)"
            }
            return "/api/data/Posts"
        }
    }
    
    var baseURL: String {
        return Constants.API.baseUrl
    }
    
    var body: (any Encodable)? {
        switch self{
        case .getPosts:
            return nil
        case .createPost(post:let post, token: _), .updatePost(post:let post, token: _):
            return post
        }
    }
    
    var headers: [String : String]? {
        switch self{
            case .getPosts:
            return commonHeaders
        case .createPost(post:_, token: let token), .updatePost(post:_, token: let token):
            return ["user-token": token, "Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self{
        case .getPosts(count:let count, index:let index, token:_):
            return [URLQueryItem(name: "pageSize", value: String(count)), URLQueryItem(name: "offset", value: String(index)), URLQueryItem(name: "sortBy", value: "created desc")]
        case .createPost, .updatePost:
            return nil
        }
    }
    
    
}

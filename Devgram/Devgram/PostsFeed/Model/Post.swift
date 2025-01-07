//
//  Post.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
/**
 `PostType` is an enumeration representing the different types of posts in the application.
 Supported Post Types:
 - `text`: Represents a post containing plain text.
 - `code`: Represents a post containing code snippets.
 - `link`: Represents a post containing a URL or link.
 */
enum PostType : String , Codable{
    case text 
    case code
    case link
}

/**
 `Post` is a structure representing a post in the application.
 This structs to conforms to `Codable`to parse data coming from server as object of this type.
 */
struct Post :  Codable{
    var id : Int                //An integer representing the unique identifier for the post.
    var username : String       //A string representing the name of the user who created the post.
    var userid : Int            //An integer representing the unique identifier of the user who created the post.
    var content : String        //A string containing the content of the post.
    var likes : Int             //An integer representing the number of likes the post has received.
    var posttype : String       //A string specifying the type of the post (e.g., text, code, link).
    var created : TimeInterval  //A `TimeInterval` representing the timestamp (in milliseconds) when the post was created.
    var updated : TimeInterval  //A `TimeInterval` representing the timestamp (in milliseconds) when the post was last updated.
    var likedby : [Int]         //An array of integers representing the user IDs of those who liked the post.
    var objectId : String?      //An optional string representing the unique identifier of the post in the database (used while updating an existing post).
}


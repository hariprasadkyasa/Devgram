//
//  Post.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation

enum PostType : String , Codable{
    case text 
    case code
    case link
}


struct Post :  Codable{
    var id : Int
    var username : String
    var userid : Int
    var content : String
    var likes : Int
    var posttype : String
    
}

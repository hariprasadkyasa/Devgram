//
//  Post.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
struct Post :  Codable{
    var postid : Int
    var content : String
    var user_name : String
    var user_id : Int = 1
}

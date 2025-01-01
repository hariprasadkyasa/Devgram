//
//  User.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
struct User : Codable{
    var userId : Int
    var name : String
    var token : String?
    var email : String
    
    enum CodingKeys : String, CodingKey{
        case userId = "userid"
        case name = "name"
        case token = "user-token"
        case email = "email"
    }
}

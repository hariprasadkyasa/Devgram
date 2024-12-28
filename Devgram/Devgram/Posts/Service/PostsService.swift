//
//  PostsService.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation

protocol PostsService {
    func getPosts(quantity : Int, offset:Int) async -> [Post]
}


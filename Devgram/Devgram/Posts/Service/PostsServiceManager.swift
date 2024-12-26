//
//  PostsServiceManager.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import Foundation
class PostsServiceManager : PostsService{
    func getPosts(quantity: Int = 10, offset: Int = 0, completion: @escaping ([Post], Error?) -> Void) {
        
        let postsURLString = "https://eminentnose-us.backendless.app/api/data/Posts?pageSize=\(quantity)&offset=\(offset)&sortBy=created"
        guard let postsURL = URL(string: postsURLString) else {return}
        //var request = URLRequest.init(url: postsURL)
        print("Executing")
        URLSession.shared.dataTask(with: postsURL) { data, response, error in
            print("Executed!")
            if let error = error{
                //there is an error retrieving the posts
                completion([], error)
                return
            }
            guard let responseData = data else {return}
            guard let httpResponse = response as? HTTPURLResponse else {return}
            if httpResponse.statusCode == 200{
                //parse data
                do{
                    let posts = try JSONDecoder().decode([Post].self, from: responseData)
                    completion(posts, nil)
                    
                }catch{
                    print("Parsing error: ", error)
                    completion([], error)
                }
                
            }
        }.resume()
    }
    
    
}

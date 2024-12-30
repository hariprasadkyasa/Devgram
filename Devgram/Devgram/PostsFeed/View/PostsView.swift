//
//  PostsView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
import SwiftUI

struct PostsView : View {
    @StateObject var postsViewModel: PostsViewModel
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack(spacing: 30){
                    ForEach(0..<postsViewModel.posts.count, id: \.self){ index in
                        let post = postsViewModel.posts[index]
                        PostCellView(post: post)
                    }
                }
            }
        
        }.onAppear{
            Task{
                do {
                    try await postsViewModel.loadPosts()
                }catch{
                    print("Some error occured retrieving posts!")
                }
                
            }
            
        }
        
    }
}





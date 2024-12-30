//
//  PostCellView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct PostCellView: View {
    var post : Post
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Image(systemName: "person.crop.circle")
                Text(post.user_name)
            }.padding(.leading)
            
            VStack{
                //Text(post.content)
                CodeBlockView(code: post.content)
            }
            .frame(width: UIScreen.main.bounds.width, height:200)
        }
        
    }
}

#Preview {
    PostCellView(post: Post(postid: 1, content: "Sample post", user_name: "Hari"))
}

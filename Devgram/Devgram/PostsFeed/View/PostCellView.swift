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
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "person.crop.circle")
                Text(post.username)
                    .fontWeight(.semibold)
            }.padding(.horizontal)
            
            VStack{
                switch post.posttype{
                case PostType.text.rawValue:
                    PostTextView(text: post.content)
                case PostType.code.rawValue:
                    CodeBlockView(code: post.content)
                case PostType.link.rawValue:
                    PostLinkView(linkText: post.content)
                default:
                    PostTextView(text: post.content)
                }
            }
            
        }
        
        
    }
}

#Preview {
    PostCellView(post: Post(id: 0, username: "Hari", userid: 0, content: "Sample post", likes: 0, posttype: "text"))
}

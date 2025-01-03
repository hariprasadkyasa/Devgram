//
//  PostContentView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//

import SwiftUI

enum PostDisplayMode{
    case displayModeFeed
    case displayModeProfile
}


struct PostContentView: View {
    var post: Post
    var displayMode : PostDisplayMode = .displayModeFeed
    var body: some View {
        VStack{
            switch post.posttype{
            case PostType.text.rawValue:
                PostTextView(text: post.content, displayMode: displayMode)
            case PostType.code.rawValue:
                CodeBlockView(code: post.content, displayMode: displayMode)
            case PostType.link.rawValue:
                PostLinkView(linkText: post.content, displayMode: displayMode)
            default:
                PostTextView(text: post.content, displayMode: displayMode)
            }
        }
    }
}


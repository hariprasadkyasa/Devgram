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
            VStack{
                switch post.posttype{
                case PostType.text.rawValue:
                    postTextView
                case PostType.link.rawValue:
                    postLinkView
                case PostType.code.rawValue:
                    CodeBlockView(code: post.content, displayMode: displayMode)
                default:
                    postTextView
                }
            }
            .padding(.horizontal)
            .frame(width: contentSize.width, height:contentSize.height)
            .background(contentBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: displayMode == .displayModeProfile ? 0 : 10))
            .overlay {
                if displayMode == .displayModeFeed{
                    indicatorOverlayView
                }
            }
        }
        .padding(.horizontal)
    }
    
    var contentSize : CGSize{
        var size = CGSize()
        size.width = UIScreen.main.bounds.width - 20
        size.height = 300
        if displayMode == .displayModeProfile{
            size.width = UIScreen.main.bounds.width/3 - 1
            size.height = 100
        }
        return size
    }
    
    var contentBackgroundColor : Color{
        switch post.posttype{
        case PostType.text.rawValue:
            return Color.pink.opacity(0.7)
        case PostType.code.rawValue:
            return Color.black.opacity(0.8)
        case PostType.link.rawValue:
            return Color.green.opacity(0.7)
        default:
            return Color.pink.opacity(0.7)
        }
    }
    
    var indicatorImageName : String{
        switch post.posttype{
        case PostType.text.rawValue:
            return "message.circle"
        case PostType.code.rawValue:
            return "apple.terminal.circle"
        case PostType.link.rawValue:
            return "globe"
        default:
            return "message.circle"
        }
    }
    var indicatorImageColor : Color{
        switch post.posttype{
        case PostType.text.rawValue:
            return .white
        case PostType.code.rawValue:
            return .orange
        case PostType.link.rawValue:
            return .blue
        default:
            return .white
        }
    }
    
}

extension PostContentView {
    var postTextView: some View {
        Text(post.content)
            .font(displayMode == .displayModeFeed ? .headline : .footnote)
            .multilineTextAlignment(.leading)
            .lineLimit(20)
            .foregroundStyle(.white)
    }
    
    var postLinkView: some View {
        Text(post.content)
            .font(displayMode == .displayModeFeed ? .subheadline : .footnote)
            .fontWeight(.semibold)
            .foregroundStyle(Color.blue)
    }
    
    var indicatorOverlayView: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Image(systemName: indicatorImageName)
                    .foregroundColor(indicatorImageColor)
                    .font(.title)
                    .scaleEffect(1.5)
            }.padding(30)
        }
    }
}


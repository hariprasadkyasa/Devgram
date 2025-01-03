//
//  PostLinkView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct PostLinkView: View {
    @State var linkText = ""
    var displayMode : PostDisplayMode
    var body: some View {
        VStack{
            Text(linkText)
                .font(displayMode == .displayModeFeed ? .subheadline : .footnote)
                .fontWeight(.semibold)
                .foregroundStyle(Color.blue)
            if displayMode == .displayModeFeed{
                HStack{
                    Spacer()
                    Image(systemName: "globe")
                        .foregroundColor(Color.blue)
                        .font(.title)
                        .scaleEffect(1.5)
                    
                }.padding(.horizontal, 20)
                    .offset(y: 100)

            }
            
        }
        .frame(width: contentSize.width, height:contentSize.height)
        .background(Color.green.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: displayMode == .displayModeProfile ? 0 : 10))
        
    }
    
    var contentSize : CGSize{
        var size = CGSize()
        size.width = UIScreen.main.bounds.width
        size.height = 300
        if displayMode == .displayModeProfile{
            size.width = UIScreen.main.bounds.width/3 - 1
            size.height = 100
        }
        return size
    }
}

#Preview {
    PostLinkView(linkText: "https: //developer.apple.com", displayMode: .displayModeFeed)
}

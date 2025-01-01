//
//  PostTextView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct PostTextView: View {
    @State var text : String = ""
    var displayMode : PostDisplayMode
    var body: some View {
        VStack{
            Text(text)
                .font(displayMode == .displayModeFeed ? .headline : .footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(20)
                .foregroundStyle(.white)
            if displayMode == .displayModeFeed{
                HStack{
                    Spacer()
                    Image(systemName: "message.circle")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .scaleEffect(2)
                    
                }.padding(.horizontal, 30)
                    .offset(y: 70)
            }
        }
        .frame(width: contentSize.width, height:contentSize.height)
        .background(Color.pink)
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
    PostTextView(text: "This is how the text from a sample post looks like in the preview", displayMode: .displayModeFeed)
}

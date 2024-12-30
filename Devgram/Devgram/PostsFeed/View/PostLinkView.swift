//
//  PostLinkView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct PostLinkView: View {
    @State var linkText = ""
    var body: some View {
        VStack{
            Text(linkText)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.blue)
            HStack{
                Spacer()
                Image(systemName: "globe")
                    .foregroundColor(Color.blue)
                    .font(.title)
                    .scaleEffect(2)
                
            }.padding(.horizontal, 30)
                .offset(y: 70)
            
        }
        .frame(width: UIScreen.main.bounds.width, height:300)
        .background(Color.green)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    PostLinkView(linkText: "https: //developer.apple.com")
}

//
//  PostTextView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI

struct PostTextView: View {
    @State var text : String = ""
    var body: some View {
        VStack{
            Text(text)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .lineLimit(20)
                .foregroundStyle(.white)
            
            HStack{
                Spacer()
                Image(systemName: "message.circle")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .scaleEffect(2)
                
            }.padding(.horizontal, 30)
                .offset(y: 70)
        }
        .frame(width: UIScreen.main.bounds.width, height:300)
        .background(Color.pink)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

#Preview {
    PostTextView(text: "This is how the text from a sample post looks like in the preview")
}

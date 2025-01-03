//
//  PostCellView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct PostCellView: View {
    var post : Post
    @State var liked : Bool
    @State var likedCount : Int
    let onLikeTapped: (Bool) -> Void
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "person.crop.circle")
                    .scaleEffect(1.2)
                Text(post.username)
                    .font(.headline)
                    .fontWeight(.semibold)
            }.padding(.horizontal)
            
            PostContentView(post: post)
            
            HStack{
                Button {
                    didTapLike()
                } label: {
                    Image(systemName:  liked ? "hands.clap.fill" : "hands.clap")
                        .foregroundStyle(liked ? Color.red : Color.black)
                        .scaleEffect(1.2)
                }
                Text("\(likedCount)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }.padding(.horizontal)
            
            HStack{
                let timePosted = getDisplayTextForPostedTime(post: post)
                Text(timePosted)
                Spacer()
            }.padding(.horizontal)
        }
    }

    func getDisplayTextForPostedTime(post: Post) -> String{
        let timeStamp = post.created == 0 ? post.updated : post.created
        let date = Date(timeIntervalSinceReferenceDate: timeStamp)
        let seconds = Date().timeIntervalSince(date)
        if seconds < 60 {
            return "Just now"
        } else if seconds < 3600 {
            let minutes = Int(seconds / 60)
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        } else if seconds < 86400 {
            let hours = Int(seconds / 3600)
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        } else {
            let days = Int(seconds / 86400)
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }

    }
    
    func didTapLike(){
        (liked) ? (likedCount -= 1) : (likedCount += 1)
        liked.toggle()
        onLikeTapped(liked)
    }
}


#Preview {
    PostCellView(post: Post(id: 0, username: "Hari", userid: 0, content: "Sample post", likes: 0, posttype: "text", created: 1735554088017, updated: 0, likedby: []),liked: true,likedCount: 4, onLikeTapped: {_ in })
}

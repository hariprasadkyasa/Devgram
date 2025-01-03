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
            postCreatorSection
            PostContentView(post: post)
            postInteractionsSection
            postedTimeSection
        }
    }

    func getDisplayTextForPostedTime(post: Post) -> String{
        let timeStamp = post.updated
        let date = Date(timeIntervalSinceReferenceDate: timeStamp/1000)
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

extension PostCellView {
    var postCreatorSection: some View {
        HStack{
            Image(systemName: "person.crop.circle")
                .scaleEffect(1.2)
            Text(post.username)
                .font(.headline)
                .fontWeight(.semibold)
        }.padding(.horizontal)
    }
    
    var postInteractionsSection: some View {
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
    }
    
    var postedTimeSection : some View {
        HStack{
            let timePosted = getDisplayTextForPostedTime(post: post)
            Text(timePosted)
            Spacer()
        }.padding(.horizontal)
    }
    
}

#Preview {
    PostCellView(post: Post(id: 0, username: "Hari", userid: 0, content: "Sample post", likes: 0, posttype: "text", created: 1735554088017, updated: 0, likedby: []),liked: true,likedCount: 4, onLikeTapped: {_ in })
}

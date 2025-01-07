//
//  PostCellView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI
/**
A view that represents a single post in the feed.
Displays post creator, content, interactions (like button and count), and the time since posting.
 */
struct PostCellView: View {
    var post : Post
    @State var liked : Bool
    @State var likedCount : Int
    let onLikeTapped: (Bool) -> Void
    /**
     The body of the view, rendering various sections such as creator, content, interactions, and time posted.
     */
    var body: some View {
        VStack(alignment: .leading){
            postCreatorSection // Section displaying the creator of the post.
            PostContentView(post: post) // Display the content of the post.
            postInteractionsSection // Section with the like button and like count.
            postedTimeSection // Section displaying the time since the post was made.
        }
    }

    
    /**
     Helper function to return a readable string for how long ago post was shared.
     - Parameters:
        - post: The Post object to calculate the time for
     - Returns:
     A string indicating the time ago, such as "Just now", "5 minutes ago", etc.
     */
    func getDisplayTextForPostedTime(post: Post) -> String{
        let timeStamp = post.updated
        let date = Date(timeIntervalSince1970: timeStamp/1000)
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
    
    /**
     Toggles the like state of the post and updates the like count.
     Calls the `onLikeTapped` closure with the new like state.
     */
    func didTapLike(){
        (liked) ? (likedCount -= 1) : (likedCount += 1)
        liked.toggle()
        onLikeTapped(liked)
    }
}

// MARK: - Subviews (sections of the post)
extension PostCellView {
    /**
     Section that displays the post creator's username and small placeholder display image.
     */
    var postCreatorSection: some View {
        HStack{
            Image(systemName: "person.crop.circle")
                .scaleEffect(1.2)
            Text(post.username)
                .font(.headline)
                .fontWeight(.semibold)
        }.padding(.horizontal)
    }
    
    /**
     Section with the like button and the like count.
     */
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
    /**
     Section that displays how long ago the post was posted.
     */
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

//
//  PostGridView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 01/01/25.
//

import SwiftUI

struct PostGridView: View {
    let posts: [Post]

    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
    ]

    var imageDimension = (UIScreen.main.bounds.width / 3) - 1

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(posts, id: \.id) { post in
                NavigationLink {
                    SinglePostView()
                } label: {
                    PostContentView(post: post, displayMode: .displayModeProfile)
                }
            }
        }
    }
}

#Preview {
    PostGridView(posts: [Post]())
}

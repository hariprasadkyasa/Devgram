//
//  MainTabView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
import SwiftUI

public struct MainTabView: View {
    @StateObject var postsViewModel: PostsViewModel = PostsViewModel()
    public var body: some View {
        TabView {
            PostsView(postsViewModel: postsViewModel)
                .tabItem {
                    Image(systemName: "house")
                }
            Text("New Post")
                .tabItem {
                    Image(systemName: "plus.square.fill")
                }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.crop.square")
                }
        }
        .accentColor(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    MainTabView()
}

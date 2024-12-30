//
//  MainTabView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
import SwiftUI

enum Tab: Int, Hashable {
    case posts
    case createPost
    case profile
}

public struct MainTabView: View {
    @StateObject var postsViewModel: PostsViewModel = PostsViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var selectedTab: Tab = .posts
    public var body: some View {
        TabView (selection: $selectedTab){
            PostsView(postsViewModel: postsViewModel)
                .tabItem {
                    Image(systemName: "house")
                }.tag(Tab.posts)
            CreatePostView(currentSelectedTab : $selectedTab)
                .tabItem {
                    Image(systemName: "plus.square.fill")
                }.tag(Tab.createPost)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                }.tag(Tab.profile)
        }
        .accentColor(Color.black)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden()
        .navigationTitle(Constants.Labels.AppName)
        
    }
}

#Preview {
    MainTabView()
}

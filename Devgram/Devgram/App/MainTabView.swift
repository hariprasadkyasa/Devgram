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
    @State var userSessionManager: UserSessionManager
    @State private var selectedTab: Tab = .posts
    public var body: some View {
        TabView (selection: $selectedTab){
            PostsView(userSessionManager: userSessionManager)
                .tabItem {
                    Image(systemName: "house")
                }.tag(Tab.posts)
            CreatePostView(userSessionManager: userSessionManager, currentSelectedTab : $selectedTab)
                .tabItem {
                    Image(systemName: "plus.square.fill")
                }.tag(Tab.createPost)
            ProfileView(userSessionManager: userSessionManager)
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
    MainTabView(userSessionManager: LoginViewModel())
}

//
//  MainTabView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation
import SwiftUI

/**
 An enum represents a uniue tab in the `MainTabView`
 */
enum Tab: Int, Hashable {
    case posts
    case createPost
    case profile
}


/**
 Parent and main view in the view heirarchy.
 Manages navigation between core componets of the app.
 Passes `UserSessionManager` and `PostsService` in to underlying views
 */
public struct MainTabView: View {
    @State var userSessionManager: UserSessionManager
    @State var postsService : PostsService
    @State private var selectedTab: Tab = .posts
    
    init(userSessionManager: UserSessionManager, postsService: PostsService) {
        _userSessionManager = .init(wrappedValue: userSessionManager)
        _postsService = .init(wrappedValue: postsService)
    }
    public var body: some View {
        TabView (selection: $selectedTab){
            PostsView(userSessionManager: userSessionManager, postsService: postsService)
                .tabItem {
                    Image(systemName: "house")
                }.tag(Tab.posts)
            CreatePostView(userSessionManager: userSessionManager, postsService: postsService, currentSelectedTab : $selectedTab)
                .tabItem {
                    Image(systemName: "plus.square.fill")
                }.tag(Tab.createPost)
            ProfileView(userSessionManager: userSessionManager, postsService: postsService)
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


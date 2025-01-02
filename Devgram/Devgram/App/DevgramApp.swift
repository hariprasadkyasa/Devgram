//
//  DevgramApp.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import SwiftUI

@main
struct DevgramApp: App {
    @State private var authService: AuthenticationService = AuthenticationServiceManager()
    @State private var postsService: PostsService = PostsServiceManager()
    var body: some Scene {
        WindowGroup {
            LoginView(authService: authService, postsService: postsService)
        }
    }
}

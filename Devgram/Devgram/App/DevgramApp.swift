//
//  DevgramApp.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

/// This is starting point of the app. The 'DevgramApp' creates
/// dependencies `AuthenticationService` and `PostsService`that app uses
/// and injects them in to 'LoginView' that will be passed to other views in the hierarchy

import SwiftUI

@main
struct DevgramApp: App {
    @State private var authService: AuthenticationService = AuthenticationServiceManager()
    @State private var postsService: PostsService = PostsServiceManager()
    var autoLoginEnabled = true // For UI Testing
    
    init() {
        //Check if there is a launch argument available to prevent app from autologin for UI testing
        if CommandLine.arguments.contains("--disableAutoLogin"){
            autoLoginEnabled = false
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(authService: authService, postsService: postsService, autoLoginEnabled: autoLoginEnabled)
        }
    }
}

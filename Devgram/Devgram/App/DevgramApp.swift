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
    @State var autoLoginEnabled = true // For UI Testing
    
    init() {
        if CommandLine.arguments.contains("--disableAutoLogin"){
            autoLoginEnabled = false
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(authService: authService, postsService: postsService, autoLoginEnabled: true)
        }
    }
}

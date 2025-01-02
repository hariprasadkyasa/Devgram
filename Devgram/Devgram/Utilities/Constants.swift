//
//  Constants.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
enum Constants {
    enum API {
        static let baseUrl = "eminentnose-us.backendless.app"
        static let contentType = "application/json"
        static let urlScheme = "https"
    }
    
    enum Keys {
        static let userTokenKey = "authToken"
    }
    
    enum Labels {
        static let AppName = "Devgram"
        static let NoPostsInFeedMessage = "No posts to show!"
    }
    
    enum ErrorMessages {
        static let signupErrorHeading = "Error Signing Up"
        static let invalidSignupDetailsHeading = "Invalid Details"
        static let invalidSignupDetailsMessage = "Make sure all details are correct"
        static let errorGettingAuthStatusHeading = "Could not get auth status"
        static let signInErrorHeading = "Error Signing In"
        static let signOutErrorHeading = "Error Signing Out"
        static let errorFetchingPostsHeading = "Could not load posts"
        static let errorUpdatingLikeHeading = "Could not update post"
    }
    
}

//
//  Constants.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Foundation
/**
 A container for various constant values used throughout the application.
 */
enum Constants {
    // MARK: - API Constants
    /**
     Contains constants related to the API configuration.
     */
    enum API {
        static let baseUrl = "eminentnose-us.backendless.app"
        static let contentType = "application/json"
        static let urlScheme = "https"
    }
    // MARK: - Keys
    /**
     Contains keys used for storing important data in to meory, file or keychain.
     Can also be used to retreive objects from dictionaries in the app
     */
    enum Keys {
        static let userTokenKey = "authToken"
    }
    // MARK: Labels
    /**
     Contains user-facing labels/messages used throughout the app, such as app name and UI text.
     */
    enum Labels {
        static let AppName = "Devgram"
        static let NoPostsInFeedMessage = "No posts to show!"
        static let NoPostsInProfileMessage = "You have not posted anything yet!"
        static let ProvideSignupDetailsMessage = "Provide your details"
    }
    
    // MARK: - Error Messages
    /**
     Contains predefined error messages used in different parts of the app to inform the user about issues.
     */
    enum ErrorMessages {
        static let signupErrorHeading = "Error Signing Up"
        static let invalidSignupDetailsHeading = "Invalid Details"
        static let invalidSignupDetailsMessage = "Make sure all details are correct"
        static let errorGettingAuthStatusHeading = "Could not get auth status"
        static let signInErrorHeading = "Error Signing In"
        static let signOutErrorHeading = "Error Signing Out"
        static let errorFetchingPostsHeading = "Could not load posts"
        static let errorUpdatingLikeHeading = "Could not update post"
        static let errorCreatingPostHeading = "Could not share post"
    }
    
}

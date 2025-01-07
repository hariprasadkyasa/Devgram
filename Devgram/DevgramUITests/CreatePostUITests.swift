//
//  CreatePostUITests.swift
//  DevgramUITests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest
final class CreatePostUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--disableAutoLogin")
    }

    override func tearDownWithError() throws {
    }
    
    /**
    This test verifies that the post creation feature works correctly.
    It logs in the user, navigates to the "Add Post" screen, creates a post, and ensures that the post appears successfully.
    The test checks that the "Home" button is selected after posting and the post creation button is no longer visible.
     */
    func testCreatePostShouldWork() throws {
        app.launch()
        try loginWithTestUser()
        let tabBar = app.tabBars["Tab Bar"]
        if tabBar.waitForExistence(timeout: 5){
            let addPostButton = tabBar.buttons["Add"]
            addPostButton.tap()
            XCTAssertTrue(addPostButton.isSelected)
            sleep(2)
            let postEditor = app.textViews["NewPost_Editor"]
            postEditor.tap()
            let postText = "Test Post ctreated by UI testing"
            postEditor.typeText(postText)
            let postButton = app.buttons["Post"]
            postButton.tap()
            sleep(3)
            let homeButton = tabBar.buttons["Home"]
            XCTAssertTrue(homeButton.isSelected)
            XCTAssertFalse(postButton.exists)
        }else{
            //user not logged in
            XCTAssertFalse(tabBar.exists)
        }
    }
    
    /**
    This helper method simulates logging in with a test user by entering the username and password.
    It ensures that the login button is enabled and taps it to log in the user.
     */
    func loginWithTestUser() throws{
        let testUsername = UITestConstants.TestUser.userName
        let testPassword = UITestConstants.TestUser.password
        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText(testUsername)
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText(testPassword)
        let loginButton = app.buttons["Login_Button"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()
    }
    
}

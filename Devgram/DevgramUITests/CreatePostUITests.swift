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
    
    func loginWithTestUser() throws{
        let testUsername = "hariprasad"
        let testPassword = "hariprasad"
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

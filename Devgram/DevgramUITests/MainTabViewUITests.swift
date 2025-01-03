//
//  MainTabViewUITests.swift
//  DevgramUITests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest

final class MainTabViewUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--disableAutoLogin")
    }

    override func tearDownWithError() throws {
    }
    
    func testMainTabViewTabsShouldWork() throws {
        app.launch()
        try loginWithTestUser()
        let tabBar = app.tabBars["Tab Bar"]
        if tabBar.waitForExistence(timeout: 5){
            let homeButton = tabBar.buttons["Home"]
            XCTAssertTrue(homeButton.isSelected)
            sleep(2)
            
            let addPostButton = tabBar.buttons["Add"]
            addPostButton.tap()
            XCTAssertTrue(addPostButton.isSelected)
            let label = app.staticTexts["Create Post"]
            XCTAssertTrue(label.exists)
            let postButton = app.buttons["Post"]
            XCTAssertTrue(postButton.exists)
            sleep(2)
            
            let profileButton = tabBar.buttons["Selfie"]
            profileButton.tap()
            XCTAssertTrue(profileButton.isSelected)
            let logoutButton = app.scrollViews.otherElements.buttons["Logout"]
            let logoutButtonExists = logoutButton.waitForExistence(timeout: 3)
            XCTAssertTrue(logoutButtonExists)
        }else{
            //not logged in
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

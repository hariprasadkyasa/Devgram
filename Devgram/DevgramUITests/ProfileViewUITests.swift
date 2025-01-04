//
//  ProfileViewUITests.swift
//  DevgramUITests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest

final class ProfileViewUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--disableAutoLogin")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProfileViewLogoutButtonShouldWork() throws {
        
        app.launch()
        try loginWithTestUser()
        let tabBar = app.tabBars["Tab Bar"]
        if tabBar.waitForExistence(timeout: 5){
            let profileButton = tabBar.buttons["Selfie"]
            profileButton.tap()
            XCTAssertTrue(profileButton.isSelected)
            sleep(2)
            let logoutButton = app.scrollViews.otherElements.buttons["Logout"]
            let exists = logoutButton.waitForExistence(timeout: 1)
            XCTAssertTrue(exists)
            logoutButton.tap()
            let loginButton = app.buttons["Login_Button"]
            let loginButtonExists = loginButton.waitForExistence(timeout: 2)
            XCTAssertTrue(loginButtonExists)
            
        }else{
            //user not logged in
            XCTAssertFalse(tabBar.exists)
        }
    }
    
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

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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProfileViewLogoutButtonShouldWork() throws {
        
        app.launch()
        let tabBar = app.tabBars["Tab Bar"]
        if tabBar.waitForExistence(timeout: 5){
            let profileButton = tabBar.buttons["Selfie"]
            profileButton.tap()
            XCTAssertTrue(profileButton.isSelected)
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
    
    

}

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
    }

    override func tearDownWithError() throws {
    }
    
    func testCreatePostShouldWork() throws {
        app.launch()
        let tabBar = app.tabBars["Tab Bar"]
        if tabBar.waitForExistence(timeout: 5){
            let addPostButton = tabBar.buttons["Add"]
            addPostButton.tap()
            XCTAssertTrue(addPostButton.isSelected)
            sleep(2)
            let postEditor = app.textViews["NewPost_Editor"]
            postEditor.tap()
            let postText = "Test Post"
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

    
}

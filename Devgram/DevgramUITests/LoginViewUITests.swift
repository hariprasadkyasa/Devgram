//
//  LoginViewUITests.swift
//  DevgramUITests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest

final class LoginViewUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--disableAutoLogin")
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //Run only when user has not logged in
    func testLoginViewSignupButtonShouldWorkInIntialLaunch() throws {
        app.launch()
        let loginButton = app.buttons["Login_Button"]
        let notLoggedIn = loginButton.waitForExistence(timeout: 5)
        if notLoggedIn{
            XCTAssertFalse(loginButton.isEnabled)
            loginButton.tap()
            //click in username and type an user name
            try typeTestUserNameAndPassword()
            app/*@START_MENU_TOKEN@*/.buttons["Login_Button"]/*[[".buttons[\"Login\"]",".buttons[\"Login_Button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            sleep(3)
            let homeScreen =  app.navigationBars["Devgram"]
            //check if we are in the home screen
            XCTAssertTrue(homeScreen.exists)
        }else{
            //already logged in
            XCTAssertFalse(loginButton.exists)
        }
        
    }
    
    func typeTestUserNameAndPassword() throws{
        app.textFields["Email"].tap()
        
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"h\"]",".keys[\"h\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"a\"]",".keys[\"a\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"r\"]",".keys[\"r\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"i\"]",".keys[\"i\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"p\"]",".keys[\"p\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()
        rKey.tap()
        aKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"s\"]",".keys[\"s\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        aKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"d\"]",".keys[\"d\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        app.secureTextFields["Password"].tap()
        hKey.tap()
        aKey.tap()
        rKey.tap()
        iKey.tap()
        pKey.tap()
        rKey.tap()
        aKey.tap()
        sKey.tap()
        aKey.tap()
        dKey.tap()
    }
    
    //Run only when user has not logged in
    func testSignUpButtonShouldWork() throws{
        
        app.launch()
        let signupButton = app.buttons["Signup"]
        let notSignedIn = signupButton.waitForExistence(timeout: 5)
        if notSignedIn{
            signupButton.tap()
            sleep(2)
            let title = app.staticTexts["Provide your details"]
            let signupButton = app.buttons["Sign up"]
            XCTAssertFalse(signupButton.isEnabled)
            let nameField = app.textFields["Name"]
            let emailField = app.textFields["Email"]
            let passwordField = app.secureTextFields["Password"]
            let confirmPasswordFiled = app.secureTextFields["Confirm password"]
            XCTAssertTrue(title.exists)
            XCTAssertTrue(nameField.exists)
            XCTAssertTrue(emailField.exists)
            XCTAssertTrue(passwordField.exists)
            XCTAssertTrue(confirmPasswordFiled.exists)
            XCTAssertTrue(signupButton.exists)
        }else{
            //app has logged in
            XCTAssertFalse(signupButton.exists)
        }
        
    }
}

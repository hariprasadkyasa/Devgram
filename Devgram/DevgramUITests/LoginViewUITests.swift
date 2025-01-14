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
    
    
    /**
    Run only when user has not logged in
    This test verifies that the "Login" button functions as expected on the initial app launch when the user is not logged in.
    It ensures that the login button is disabled initially, and after typing valid credentials, the user is redirected to the home screen.
     */
    func testLoginViewSigninButtonShouldWorkInIntialLaunch() throws {
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
    
    /**
     Helper method to type the test username and password into the login form fields.
     */
    func typeTestUserNameAndPassword() throws{
        let testUsername = UITestConstants.TestUser.userName
        let testPassword = UITestConstants.TestUser.password
        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText(testUsername)
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText(testPassword)
    }
    
    /**
    This test verifies that the "Sign Up" button works as expected when the user is not logged in.
    It ensures that tapping the sign-up button leads to a screen with the necessary fields for the user to sign up, and checks if the sign-up button is initially disabled.
     */
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

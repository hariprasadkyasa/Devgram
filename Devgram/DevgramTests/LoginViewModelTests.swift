//
//  LoginViewModelTests.swift
//  DevgramTests
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//

import XCTest
@testable import Devgram

final class LoginViewModelTests: XCTestCase {

    var uut : LoginViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockUser = User(userId: 1, name: "Test User", email: "test@abc.com")
        let mockAuthService = MockAuthenticationService(mockUser: mockUser)
        uut = LoginViewModel(authService: mockAuthService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        uut = nil
    }
    
    func testLoginViewModelShouldNotBeNil() {
        XCTAssertNotNil(uut)
    }
    
    /**
     This test verifies that when valid user details are provided, the login process succeeds.
     It ensures that there are no error messages, the current user is set, and the login state is authenticated.
     */
    func testUserLoginShouldSucess() async{
        //when we provide valida user details
        //there shluld be no error message
        //and the currentUser object should not be nil
        if let loginViewModel = uut {
            let expectation = XCTestExpectation(description: "user_login")
            loginViewModel.username = "test@abc.com"
            loginViewModel.password = "test1234"
            await uut?.login()
            expectation.fulfill()
            XCTAssertEqual(loginViewModel.messageToDisplay.message, "")
            XCTAssertNotNil(loginViewModel.currentUser)
            XCTAssertFalse(loginViewModel.displayMessage)
            XCTAssertTrue(loginViewModel.userAuthenticated)
            await fulfillment(of: [expectation], timeout: 2.0)
        }else{
            XCTFail("LoginViewModel is nil")
        }
    }
    
    /**
    This test verifies that when invalid user details are provided, the login process fails.
    It checks that an error message is displayed, the current user is nil, and the user authentication state is false.
     */
    func testUserLoginShouldFail() async{
        if let loginViewModel = uut {
            let expectation = XCTestExpectation(description: "user_login")
            loginViewModel.username = "Other User"
            loginViewModel.password = "test1234"
            await uut?.login()
            expectation.fulfill()
            XCTAssertNotEqual(loginViewModel.messageToDisplay.message, "")
            XCTAssertTrue(loginViewModel.displayMessage)
            XCTAssertNil(loginViewModel.currentUser)
            XCTAssertFalse(loginViewModel.userAuthenticated)
            await fulfillment(of: [expectation], timeout: 2.0)
        }
    }
    
    /**
    This test verifies that after a successful login, the authentication state is valid.
    It ensures the user is authenticated, the message is empty, and the current user is properly set.
     */
    func testAuthenticationStateShouldBeValid() async{
        //test to check the autheticate status to be valid
        //after successful login
        if let loginViewModel = uut {
            let loginExpectation = XCTestExpectation(description: "user_login")
            loginViewModel.username = "test@abc.com"
            loginViewModel.password = "test1234"
            await uut?.login()
            loginExpectation.fulfill()
            let authStateExpectation = XCTestExpectation(description: "authentication_state")
            await loginViewModel.checkIfUserAuthenticated()
            authStateExpectation.fulfill()
            XCTAssertTrue(loginViewModel.userAuthenticated)
            XCTAssertEqual(loginViewModel.messageToDisplay.message, "")
            XCTAssertFalse(loginViewModel.displayMessage)
            XCTAssertNotNil(loginViewModel.currentUser)
            XCTAssertTrue(loginViewModel.userAuthenticated)
            await fulfillment(of: [authStateExpectation, loginExpectation], timeout: 3.0)
        }
    }
    
    /**
    This test verifies that when the user is not authenticated, the authentication state is invalid.
    It ensures that the user authentication state is false, and the current user is nil.
     */
    func testAuthenticationStateShouldBeInValid() async{
        if let loginViewModel = uut {
            let expectation = XCTestExpectation(description: "authentication_state")
            await loginViewModel.checkIfUserAuthenticated()
            expectation.fulfill()
            XCTAssertFalse(loginViewModel.userAuthenticated)
            XCTAssertNil(loginViewModel.currentUser)
            XCTAssertFalse(loginViewModel.userAuthenticated)
            await fulfillment(of: [expectation], timeout: 2.0)
        }
    }

    

}

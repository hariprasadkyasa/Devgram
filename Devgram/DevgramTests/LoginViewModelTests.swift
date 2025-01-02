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
    
    func testUserLoginShouldSucess() async{
        //when we provide valida user details
        //there shluld be no error message
        //and the currentUser object should not be nil
        if let loginViewModel = uut {
            let expectation = XCTestExpectation(description: "user_login")
            loginViewModel.username = "Test User"
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
    
    func testAuthenticationStateShouldBeValid() async{
        //test to check the autheticate status to be valid
        //after successful login
        if let loginViewModel = uut {
            let loginExpectation = XCTestExpectation(description: "user_login")
            loginViewModel.username = "Test User"
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
    
    func testAuthenticationStateShouldBeInValid() async{
        //test to check the autheticate status to be valid
        //after successful login
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

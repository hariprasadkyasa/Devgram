//
//  SignupViewModelTests.swift
//  DevgramTests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest
@testable import Devgram
final class SignupViewModelTests: XCTestCase {

    func testSignupShouldFailWithEmptyFields() async{
        let mockService = MockAuthenticationService(mockUser: nil)
        let viewModel = SignupViewModel(authService: mockService)
        viewModel.username = ""
        let expectation = XCTestExpectation(description: "signup")
        if let user = await viewModel.signup(){
            XCTFail("signup process should not success")
        }else {
            XCTAssertEqual(viewModel.messageToDisplay.heading, Constants.ErrorMessages.invalidSignupDetailsHeading)
            XCTAssertTrue(viewModel.displayMessage)
        }
    }
    
    func testSignupShouldFailWithInvalidFields() async{
        let mockService = MockAuthenticationService(mockUser: nil)
        let viewModel = SignupViewModel(authService: mockService)
        viewModel.email = "abusive@xyz.com"
        let expectation = XCTestExpectation(description: "signup")
        if (await viewModel.signup()) != nil{
            XCTFail("signup process should not success")
        }else {
            XCTAssertEqual(viewModel.messageToDisplay.heading, Constants.ErrorMessages.invalidSignupDetailsHeading)
            XCTAssertTrue(viewModel.displayMessage)
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func testSignupShouldSucess() async{
        let mockService = MockAuthenticationService(mockUser: User(userId: 0, name: "test user", email: "test@xyz.com"))
        let viewModel = SignupViewModel(authService: mockService)
        viewModel.username = "test user"
        viewModel.password = "test password"
        viewModel.confirmPassword = "test password"
        viewModel.email = "test@xyz.com"
        let expectation = XCTestExpectation(description: "signup")
        if let user = await viewModel.signup(){
            XCTAssertEqual(viewModel.messageToDisplay.heading, "")
            XCTAssertFalse(viewModel.displayMessage)
            XCTAssertEqual(user.name, viewModel.username)
            XCTAssertEqual(user.email, viewModel.email)
            
        }else {
            XCTFail("signup process should be success")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 1)
    }
}

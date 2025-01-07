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
    
    /**
    This test simulates a scenario where the user attempts to sign up with invalid fields (e.g., email).
    It verifies that the sign-up process fails, an error message is displayed, and the appropriate heading for invalid signup details is shown.
     */
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
    
    /**
    This test simulates a scenario where the user successfully signs up with valid fields.
    It verifies that the sign-up process succeeds, the error message is not displayed, and the returned user data matches the input details.
     */
    func testSignupShouldSucess() async{
        let mockService = MockAuthenticationService(mockUser: User(userId: 0, name: "test_user", email: "test@xyz.com"))
        let viewModel = SignupViewModel(authService: mockService)
        viewModel.username = "test_user"
        viewModel.password = "test_password"
        viewModel.confirmPassword = "test_password"
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

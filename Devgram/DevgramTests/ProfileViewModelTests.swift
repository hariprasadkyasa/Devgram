//
//  ProfileViewModelTests.swift
//  DevgramTests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest
@testable import Devgram

final class ProfileViewModelTests: XCTestCase {
    
    func testGetUserPostsShouldSucess() async{
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = ProfileViewModel(postsService: mockService)
        let expectation = expectation(description: "get_user_posts")
        await viewModel.fetchUserPosts(userId: 0)
        expectation.fulfill()
        XCTAssertTrue(viewModel.posts.count == mockService.mockPosts.count)
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func testGetUserPostsShouldFail() async{
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = ProfileViewModel(postsService: mockService)
        let expectation = expectation(description: "get_user_posts")
        mockService.simulateError = true
        await viewModel.fetchUserPosts(userId: 0)
        expectation.fulfill()
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertEqual(viewModel.messageToDisplay.heading, Constants.ErrorMessages.errorFetchingPostsHeading)
        await fulfillment(of: [expectation], timeout: 1)
    }

}

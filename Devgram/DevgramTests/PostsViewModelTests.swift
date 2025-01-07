//
//  PostsViewModelTests.swift
//  DevgramTests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest
@testable import Devgram

final class PostsViewModelTests: XCTestCase {
    var uut : PostsViewModel?
    var mockService : MockPostsService?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockService = MockPostsService(mockPosts: nil)
        uut = PostsViewModel(postsService: mockService!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        uut = nil
    }
    
    /**
     This test verifies that when posts are successfully loaded, the `posts` array contains data, no error message is displayed, and the `displayMessage` flag is false.
     */
    func testFetchPostsShouldSuccess() async{
        if let postsViewModel = uut{
            let expectation = XCTestExpectation(description: "load_posts_expectation")
            await postsViewModel.loadPosts()
            expectation.fulfill()
            XCTAssertTrue(postsViewModel.posts.count > 0)
            XCTAssertEqual(postsViewModel.messageToDisplay.message, "")
            XCTAssertFalse(postsViewModel.displayMessage)
            await fulfillment(of: [expectation], timeout: 1)
        }
    }
    
    /**
    This test simulates a failure scenario where an error occurs while fetching posts.
    It verifies that no posts are loaded, the error message is shown, and the `displayMessage` flag is true.
     */
    func testFetchPostsShouldFail() async{
        if let postsViewModel = uut{
            let expectation = XCTestExpectation(description: "load_posts_expectation")
            if let mockService = mockService{
                mockService.simulateError = true
            }
            await postsViewModel.loadPosts()
            expectation.fulfill()
            XCTAssertTrue(postsViewModel.posts.count == 0)
            XCTAssertEqual(postsViewModel.messageToDisplay.heading, Constants.ErrorMessages.errorFetchingPostsHeading)
            XCTAssertTrue(postsViewModel.displayMessage)
            await fulfillment(of: [expectation], timeout: 1)
        }
    }

    /**
    This test verifies that posts for a specific user are fetched successfully.
    It ensures that the number of posts matches the mock service's posts count.
     */
    func testGetUserPostsShouldSucess() async{
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = PostsViewModel(postsService: mockService)
        let expectation = expectation(description: "get_user_posts")
        await viewModel.loadPosts(userId: 0)
        expectation.fulfill()
        XCTAssertTrue(viewModel.posts.count == mockService.mockPosts.count)
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    /**
    This test simulates a failure scenario when attempting to fetch posts for a specific user.
    It ensures that no posts are fetched, and an appropriate error message is shown.
     */
    func testGetUserPostsShouldFail() async{
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = PostsViewModel(postsService: mockService)
        let expectation = expectation(description: "get_user_posts")
        mockService.simulateError = true
        await viewModel.loadPosts(userId: 0)
        expectation.fulfill()
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertEqual(viewModel.messageToDisplay.heading, Constants.ErrorMessages.errorFetchingPostsHeading)
        await fulfillment(of: [expectation], timeout: 1)
    }
    
}

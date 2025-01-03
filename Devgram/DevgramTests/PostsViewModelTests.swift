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

    
    func testGetUserPostsShouldSucess() async{
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = PostsViewModel(postsService: mockService)
        let expectation = expectation(description: "get_user_posts")
        await viewModel.loadPosts(userId: 0)
        expectation.fulfill()
        XCTAssertTrue(viewModel.posts.count == mockService.mockPosts.count)
        await fulfillment(of: [expectation], timeout: 1)
    }
    
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

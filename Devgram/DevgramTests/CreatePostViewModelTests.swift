//
//  CreatePostViewModelTests.swift
//  DevgramTests
//
//  Created by Raghavendra Hariprasad Kyasa on 03/01/25.
//

import XCTest
@testable import Devgram
final class CreatePostViewModelTests: XCTestCase {

    func testCreatePostShouldSuccess() async {
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = CreatePostViewModel(postsService: mockService)
        let expectation = expectation(description: "create_post")
        do{
            try await viewModel.createPost(type: 0, for: User(userId: 1, name: "test user", email: "test@test.com"))
        }catch let error{
            XCTFail("Should not throw any error \(error)")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func testCreatePostShouldFail() async {
        let mockService = MockPostsService(mockPosts: nil)
        let viewModel = CreatePostViewModel(postsService: mockService)
        let expectation = expectation(description: "create_post")
        do{
            try await viewModel.createPost(type: 0, for: User(userId: 0, name: "test user", email: "test@test.com"))//passing user id 0 to trigger error
        }catch let error{
            XCTAssertNotNil(error)
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 1)
    }

}
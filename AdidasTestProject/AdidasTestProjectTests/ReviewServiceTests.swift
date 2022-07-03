//
//  ReviewServiceTests.swift
//  AdidasTestProjectTests
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import XCTest
@testable import AdidasTestProject

class ReviewServiceTests: XCTestCase {
    let reviewService: ReviewService = MockReviewService()

    func testGetReviews() throws {
        // Given
        let productId: String = UUID().uuidString
        let expectation: XCTestExpectation = .init(description: #function)
        var result: Bool = false

        // When
        reviewService.getReviews(productId: productId) { response in
            switch response {
                case .success:
                    result = true
                case .failure:
                    result = false
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
        XCTAssertTrue(result)
    }

    func testSendReview() throws {
        // Given
        let review: RequestModels.ReviewModel = .init(
            productId: UUID().uuidString,
            locale: UUID().uuidString,
            rating: 1,
            text: UUID().uuidString
        )
        let expectation: XCTestExpectation = .init(description: #function)
        var result: Bool = false

        // When
        reviewService.sendReview(review: review) { response in
            switch response {
                case .success:
                    result = true
                case .failure:
                    result = false
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
        XCTAssertTrue(result)
    }
}

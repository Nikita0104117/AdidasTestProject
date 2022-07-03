//
//  ProductServiceTests.swift
//  AdidasTestProjectTests
//
//  Created by Nikita Omelchenko on 03.07.2022.
//

import XCTest
@testable import AdidasTestProject

class ProductServiceTests: XCTestCase {
    let productService: ProductService = MockProductService()

    func testGetProducts() throws {
        // Given
        let expectation: XCTestExpectation = .init(description: #function)
        var result: Bool = false

        // When
        productService.getProducts { response in
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

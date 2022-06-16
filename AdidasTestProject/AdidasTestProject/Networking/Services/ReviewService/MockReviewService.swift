//
//  MockReviewService.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct MockReviewService: ReviewService {
    func getReviews(productId: String, completion: @escaping (Result<[ReviewEntity], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(ResponseModels.ReviewModel.mockData))
        }
    }

    func sendReview(review: RequestModels.ReviewModel, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(()))
        }
    }
}

private extension ResponseModels.ReviewModel {
    static var mockData: [Self] {
        [
            .init(productId: "test1", locale: "en", rating: 3, text: "Test Review"),
            .init(productId: "test2", locale: "en", rating: 3, text: "Test Review"),
            .init(productId: "test3", locale: "en", rating: 3, text: "Test Review"),
            .init(productId: "test4", locale: "en", rating: 3, text: "Test Review"),
            .init(productId: "test5", locale: "en", rating: 3, text: "Test Review")
        ]
    }
}

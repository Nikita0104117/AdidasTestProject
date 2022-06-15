//
//  RestReviewService.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct RestReviewService: BaseRestService {
    let restClient: NetworkingSessionProtocol
}

extension RestReviewService: ReviewService {
    func getReviews(productId: String, completion: @escaping (Result<[ReviewEntity], Error>) -> Void) {
        guard
            let request = restClient.request(RequestRouter.Review.getReviews(productId: productId))
        else {
            completion(.failure(URLError(.badURL)))
            return
        }

        request.responseData { [restClient] response in
            switch response.result {
                case .success(let data):
                    guard
                        let object: [ResponseModels.ReviewModel] = restClient.objectfromData(data)
                    else {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }

                    completion(.success(object))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

    func sendReview(review: RequestModels.ReviewModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard
            let request = restClient.request(RequestRouter.Review.sendReview(review: review))
        else {
            completion(.failure(URLError(.badURL)))
            return
        }

        request.responseData { response in
            switch response.result {
                case .success:
                    guard
                        response.response?.status == .created
                    else {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }

                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

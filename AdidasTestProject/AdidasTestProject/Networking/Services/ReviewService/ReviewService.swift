//
//  ReviewService.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Alamofire

protocol ReviewService {
    func getReviews(productId: String, completion: @escaping (Result<[ReviewEntity], Error>) -> Void)
    func sendReview(review: RequestModels.ReviewModel, completion: @escaping (Result<Void, Error>) -> Void)
}

extension RequestRouter {
    enum Review {
        case getReviews(productId: String)
        case sendReview(review: RequestModels.ReviewModel)
    }
}

extension RequestRouter.Review: NetworkingRouterProtocol {
    var path: Endpoint {
        switch self {
            case .getReviews(let data):
                return "reviews/\(data)"
            case .sendReview(let data):
                return "reviews/\(data.productId ?? "")"
        }
    }

    var method: HTTPMethod {
        switch self {
            case .getReviews:
                return .get
            case .sendReview:
                return .post
        }
    }

    var parameters: Encodable? {
        switch self {
            case .getReviews:
                return nil
            case .sendReview(let data):
                return data
        }
    }
}

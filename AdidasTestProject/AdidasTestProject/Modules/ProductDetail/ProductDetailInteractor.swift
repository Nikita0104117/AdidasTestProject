//
//  ProductDetailInteractor.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 16.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductDetailModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies
        weak var output: InteractorOutput!

        let dataBaseManager: DBProtocol
        let reviewService: ReviewService

        required init(dataBaseManager: DBProtocol, reviewService: ReviewService) {
            self.dataBaseManager = dataBaseManager
            self.reviewService = reviewService
        }
    }
}

extension Interactor {
    private func saveReviewsToDB(_ reviews: [ReviewEntity], productId: String?) {
        dataBaseManager.saveReviewsToDB(reviews: reviews, productId: productId)
    }

    private func getReviewsFromDB(_ productId: String) {
        dataBaseManager.getReviewsFromDB(productId: productId) { [weak self] data in
            self?.output?.successGetReviews(data)
        }
    }

    private var isConnectedToInternet: Bool {
        RestClient.isConnectedToInternet()
    }
}

extension Interactor: Module.InteractorInput {
    func sendReview(rating: Int, text: String, productId: String?, locale: String?) {
        if !isConnectedToInternet {
            output?.failure(error: "Failure connected to Internet")
            return
        }

        let reviewModel: RequestModels.ReviewModel = .init(productId: productId, locale: locale, rating: rating, text: text)
        reviewService.sendReview(review: reviewModel) { [weak self] result in
            switch result {
                case .success:
                    self?.output?.successSendReviews(reviewModel)
                case .failure(let error):
                    self?.output?.failure(error: error.localizedDescription)
            }
        }
    }

    func getReviews(_ productId: String) {
        if !isConnectedToInternet {
            output?.offlineMode()
            getReviewsFromDB(productId)
            return
        }

        reviewService.getReviews(productId: productId) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.saveReviewsToDB(data, productId: productId)
                    self?.output?.successGetReviews(data)
                case .failure(let error):
                    self?.output?.failure(error: error.localizedDescription)
            }
        }
    }
}

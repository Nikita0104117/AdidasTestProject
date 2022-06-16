//
//  ProductDetailPresenter.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 16.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductDetailModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies
        weak var controller: ControllerInput?

        var interactor: InteractorInput!
        var router: RouterInput!

        let product: ProductEntity?

        var reviews: [ReviewEntity] = [] {
            didSet {
                controller?.reloadReviewData(reviews)
            }
        }

        required init(product: ProductEntity?) {
            self.product = product
        }
    }
}

private extension Presenter { }

extension Presenter: Module.ControllerOutput {
    func didLoad() {
        guard let product = product else { return }

        controller?.feelProductInfo(product)
        interactor.getReviews(product.id ?? "")
    }

    func tapSendReview(rating: Int, text: String) {
        interactor?.sendReview(rating: rating, text: text, productId: product?.id, locale: "en")
    }
}

extension Presenter: Module.InteractorOutput {
    func successSendReviews(_ review: ReviewEntity) {
        reviews.append(review)
    }

    func successGetReviews(_ reviews: [ReviewEntity]) {
        controller?.reloadReviewData(reviews)
    }

    func offlineMode() {
        controller?.showNetworking(info: AppLocale.General.offlinemode)
    }

    func failure(error: String) {
        controller?.showNetworking(error: error)
    }
}

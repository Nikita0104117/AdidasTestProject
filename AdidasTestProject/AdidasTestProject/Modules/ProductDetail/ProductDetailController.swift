//
//  ProductDetailController.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 16.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher

private typealias Module = ProductDetailModule
private typealias Controller = Module.Controller

extension Module {
    final class Controller: UIViewController {
        // MARK: - Dependencies
        var output: ControllerOutput?
        var viewOutput: (UIView & ViewOutput)?

        // MARK: - Properties

        // MARK: - Init
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() { super.init(nibName: nil, bundle: nil) }

        // MARK: - Lifecycle
        override func loadView() {
            super.loadView()

            self.view = viewOutput
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            commonSetup()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            output?.willAppear()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            output?.didAppear()
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)

            output?.didDisappear()
        }
    }
}

private extension Controller {
    private func commonSetup() {
        title = AppLocale.ProductDetail.title

        viewOutput?.sendReviewView.sendHandler = { rating, text in
            guard
                let rating: Int = .init(rating ?? ""),
                let text = text
            else { return }

            self.output?.tapSendReview(rating: rating, text: text)
        }
    }
}

extension Controller: Module.ControllerInput {
    func reloadReviewData(_ reviews: [ReviewEntity]) {
        viewOutput?.reviewStackView.removeAllArrangedSubviews()
        reviews.forEach { viewOutput?.reviewStackView.addArrangedSubview(ReviewDetailView($0)) }
    }

    func feelProductInfo(_ product: ProductEntity) {
        viewOutput?.titleLabel.text = product.name
        viewOutput?.subTitleLabel.text = product.descriptionText
        viewOutput?.priceLabel.text = product.priceText

        guard let imageUrl = URL(string: product.imgUrl ?? "") else { return }

        viewOutput?.productImageView.kf.setImage(with: imageUrl, placeholder: Style.SystemImages.defaulProductImage)
    }
}

//
//  ProductDetailView.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 16.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

private typealias Module = ProductDetailModule
private typealias View = Module.View

extension Module {
    final class View: UIView, Module.ViewOutput {
        // MARK: - UI Elements
        private lazy var scrollView: UIScrollView = .init()
        private lazy var rootView: UIView = .init()

        private lazy var contentStackView: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack0
            $0.spacing = 32
        }

        private lazy var titleStackView: UIStackView = build {
            $0 <~ Style.Stack.defaultHorizontalStack8
        }

        private(set) lazy var reviewStackView: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack8
        }

        private(set) lazy var productImageView: UIImageView = build {
            $0 <~ Style.ImageView.imageViewWithDefaultCornerRadius
            $0.tintColor = AppColors.black.color
            $0.image = Style.SystemImages.defaulProductImage
        }

        private(set) lazy var titleLabel: UILabel = build {
            $0 <~ Style.Label.titleLabel32
        }

        private(set) lazy var subTitleLabel: UILabel = build {
            $0 <~ Style.Label.subTitleLabel20
        }

        private(set) lazy var priceLabel: UILabel = build {
            $0 <~ Style.Label.priceTitleLabel28
            $0.textAlignment = .right
        }

        private lazy var titleGiveReviewLabel: UILabel = build {
            $0 <~ Style.Label.priceTitleLabel28
            $0.text = AppLocale.ProductDetail.giveFeedback
        }

        private lazy var titleReviewsListLabel: UILabel = build {
            $0 <~ Style.Label.priceTitleLabel28
            $0.text = AppLocale.ProductDetail.feedbackList
        }

        private(set) lazy var sendReviewView: MakeReviewView = .init()

        // MARK: - Init
        init() {
            super.init(frame: .zero)

            commonSetup()
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }
}

extension View {
    private func commonSetup() {
        backgroundColor = AppColors.white.color

        addSubview(scrollView)

        scrollView.addSubview(rootView)
        rootView.addSubview(contentStackView)

        contentStackView.addArrangedSubviews(
            productImageView,
            titleStackView,
            subTitleLabel,
            titleGiveReviewLabel,
            sendReviewView,
            titleReviewsListLabel,
            reviewStackView
        )
        titleStackView.addArrangedSubviews(titleLabel, priceLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        rootView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }

        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        productImageView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
    }
}

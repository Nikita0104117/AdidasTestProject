//
//  ReviewDetailView.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 16.06.2022.
//

import UIKit
import SnapKit

class ReviewDetailView: UIView {
    private lazy var contentStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultVerticalStack8
    }

    private lazy var ratingLabel: UILabel = build {
        $0 <~ Style.Label.titleLabel16
    }

    private lazy var textLabel: UILabel = build {
        $0 <~ Style.Label.titleLabel16
    }

    convenience init(_ review: ReviewEntity) {
        self.init(frame: .zero)

        ratingLabel.text = "\(AppLocale.General.rating) \(review.rating ?? 0)"
        textLabel.text = review.text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonSetup() {
        backgroundColor = AppColors.white.color
        layer.cornerRadius = Style.CornerRadius.default
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = AppColors.blue.color.cgColor

        addSubview(contentStackView)

        contentStackView.addArrangedSubviews(ratingLabel, textLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}

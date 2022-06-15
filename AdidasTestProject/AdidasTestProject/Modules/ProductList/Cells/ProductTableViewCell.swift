//
//  ProductTableViewCell.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    // MARK: - UI Elements
    private lazy var contentStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultHorizontalStack8
    }

    private lazy var titleStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultVerticalStack8
    }

    private lazy var subTitleStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultHorizontalStack8
    }

    private lazy var productImageView: UIImageView = build {
        $0 <~ Style.ImageView.imageViewWithNormalCornerRadius
        $0.tintColor = AppColors.black.color
        $0.image = Style.SystemImages.defaulProductImage
    }

    private lazy var titleLabel: UILabel = build {
        $0 <~ Style.Label.titleLabel
    }

    private lazy var subTitleLabel: UILabel = build {
        $0 <~ Style.Label.subTitleLabel
    }

    private lazy var priceLabel: UILabel = build {
        $0 <~ Style.Label.priceTitleLabel
        $0.textAlignment = .right
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonSetup() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(contentStackView)

        contentStackView.addArrangedSubviews(productImageView, titleStackView)
        titleStackView.addArrangedSubviews(titleLabel, subTitleStackView)
        subTitleStackView.addArrangedSubviews(subTitleLabel, priceLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        productImageView.snp.makeConstraints { make in
            make.size.equalTo(60)
        }
    }

    // MARK: - Public Methods
    func configurate(_ product: ProductEntity) {
        titleLabel.text = product.name
        subTitleLabel.text = product.descriptionText
        priceLabel.text = product.priceText

        guard let imageUrl = URL(string: product.imgUrl ?? "") else { return }

        productImageView.kf.setImage(with: imageUrl, placeholder: Style.SystemImages.defaulProductImage)
    }
}

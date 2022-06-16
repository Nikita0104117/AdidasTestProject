//
//  Style+ImageView.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

extension Style.ImageView {
    static let imageViewWithNormalCornerRadius: ImageView = .init(contentMode: .scaleAspectFit, cornerRadius: Style.CornerRadius.normal)
    static let imageViewWithDefaultCornerRadius: ImageView = .init(contentMode: .scaleAspectFit, cornerRadius: Style.CornerRadius.default)
}

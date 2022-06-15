//
//  Style+Label.swift
//  TestProject
//
//  Created by Nikita Omelchenko on 07.05.2022.
//

import UIKit

extension Style.Label {
    static let titleLabel = ColoredLabel(titleColor: AppColors.black.color, font: Style.Font.systemBold16)
    static let subTitleLabel = ColoredLabel(titleColor: AppColors.black.color, font: Style.Font.system10)
    static let priceTitleLabel = ColoredLabel(titleColor: AppColors.black.color, font: Style.Font.systemBold14)
}

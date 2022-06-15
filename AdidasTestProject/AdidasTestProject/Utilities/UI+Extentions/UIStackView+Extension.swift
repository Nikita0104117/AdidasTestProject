//
//  UIStackView+Extension.swift
// AdidasTestProject
//
//  Created by Nikita Omelchenko on 07.05.2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}

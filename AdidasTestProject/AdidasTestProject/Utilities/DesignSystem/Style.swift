//
//  Style.swift
//
//
//  Created by Nikita Omelchenko
//

import Foundation
import UIKit

enum Style {
    enum Font { }

    enum Label {
        struct ColoredLabel: Applicable {
            var titleColor: UIColor
            var font: UIFont
            var numberOfLines: Int = 0

            func apply(_ object: UILabel) {
                object.textColor = titleColor
                object.font = font
                object.numberOfLines = numberOfLines
            }
        }
    }

    enum TextView {
        struct ColoredTextView: Applicable {
            var textColor: UIColor
            var font: UIFont

            func apply(_ object: UITextView) {
                object.textColor = textColor
                object.font = font
            }
        }
    }

    enum Stack {
        struct DefaulStack: Applicable {
            let spacing: CGFloat
            let axis: NSLayoutConstraint.Axis
            var alignment: UIStackView.Alignment = .fill
            var distribution: UIStackView.Distribution = .fill

            func apply(_ object: UIStackView) {
                object.spacing = spacing
                object.alignment = alignment
                object.distribution = distribution
                object.axis = axis
            }
        }

        static let defaultHorizontalStack = DefaulStack(spacing: 0, axis: .horizontal)
        static let defaultVerticalStack = DefaulStack(spacing: 0, axis: .vertical)
    }

    enum TextField {
        struct ColoredTextField: Applicable {
            let color: UIColor
            let font: UIFont
            var borderColor: UIColor?

            func apply(_ object: UITextField) {
                object.borderStyle = .none
                object.textColor = color
                object.font = font

                if let borderColor = self.borderColor {
                    object.layer.borderColor = borderColor.cgColor
                    object.layer.borderWidth = 1
                }
            }
        }
    }

    enum Button {
        struct ColoredButton: Applicable {
            var background: UIColor?
            var border: UIColor?
            var title: UIColor?
            var cornerRadius: CGFloat?
            let font: UIFont?
            var contentEdgeInsets: UIEdgeInsets?
            var image: UIImage?
            var selectedImage: UIImage?

            init(
                background: UIColor? = nil,
                border: UIColor? = nil,
                title: UIColor? = nil,
                font: UIFont? = nil,
                cornerRadius: CGFloat? = nil,
                contentEdgeInsets: UIEdgeInsets? = nil,
                image: UIImage? = nil,
                selectedImage: UIImage? = nil
            ) {
                self.background = background
                self.border = border
                self.title = title
                self.cornerRadius = cornerRadius
                self.font = font
                self.contentEdgeInsets = contentEdgeInsets
                self.image = image
                self.selectedImage = selectedImage
            }

            func apply(_ object: UIButton) {
                object.layer.masksToBounds = true

                if let background = background {
                    object.backgroundColor = background
                }

                if let border = border {
                    object.layer.borderWidth = 1
                    object.layer.borderColor = border.cgColor
                }

                if let title = title {
                    object.setTitleColor(title, for: .normal)
                    object.setTitleColor(title.withAlphaComponent(0.5), for: .disabled)
                    object.setTitleColor(title.withAlphaComponent(0.7), for: .highlighted)
                    object.setTitleColor(title.withAlphaComponent(0.7), for: .selected)
                }

                if let cornerRadius = cornerRadius {
                    object.layer.cornerRadius = cornerRadius
                }

                if let contentEdgeInsets = contentEdgeInsets {
                    object.contentEdgeInsets = contentEdgeInsets
                }

                if let image = image {
                    object.setImage(image, for: .normal)
                }

                if let selectedImage = selectedImage {
                    object.setImage(selectedImage, for: .selected)
                }

                if let font = font {
                object.titleLabel?.font = font
                }
            }
        }
    }

    enum Margins {
        static let defaultInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let zeroInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

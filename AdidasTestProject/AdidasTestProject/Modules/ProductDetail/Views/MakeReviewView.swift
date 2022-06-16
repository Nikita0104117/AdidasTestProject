//
//  MakeReviewView.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 16.06.2022.
//

import UIKit
import SnapKit

class MakeReviewView: UIView {
    private lazy var contentStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultVerticalStack0
        $0.spacing = 16
    }

    private lazy var inputStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultHorizontalStack8
    }

    private lazy var ratingStackView: UIStackView = build {
        $0 <~ Style.Stack.defaultHorizontalStack8
    }

    private lazy var ratingLabel: UILabel = build {
        $0 <~ Style.Label.titleLabel16
        $0.text = AppLocale.General.rating
    }

    private lazy var ratingTextField: UITextField = build {
        $0.inputView = pickerView
        $0.borderStyle = .roundedRect
        $0.placeholder = "0"
        $0.delegate = self
    }

    private lazy var inputTextField: UITextField = build {
        $0.borderStyle = .roundedRect
        $0.placeholder = AppLocale.ProductDetail.placholderReview
    }

    private lazy var sendButton: UIButton = build(.init(type: .system)) {
        var config = UIButton.Configuration.filled()
        config.title = AppLocale.ProductDetail.buttonTitle
        config.image = Style.SystemImages.sendImage
        config.baseBackgroundColor = AppColors.blue.color
        $0.configuration = config
        $0.addAction(sendAction, for: .touchUpInside)
    }

    private lazy var sendAction: UIAction = .init { _ in
        self.sendHandler?(self.ratingTextField.text, self.inputTextField.text)
    }

    private lazy var pickerView: UIPickerView = build {
        $0.delegate = self
    }

    private let dataSource: [String] = ["1", "2", "3", "4", "5"]

    public var sendHandler: ((_ rating: String?, _ text: String?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonSetup() {
        backgroundColor = AppColors.white.color

        addSubview(contentStackView)

        contentStackView.addArrangedSubviews(inputStackView, sendButton)
        inputStackView.addArrangedSubviews(ratingStackView, inputTextField)
        ratingStackView.addArrangedSubviews(ratingLabel, ratingTextField)

        makeConstraints()
    }

    private func makeConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        sendButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}

extension MakeReviewView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSource.count
    }
}

extension MakeReviewView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ratingTextField.text = dataSource[row]
    }
}

extension MakeReviewView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = dataSource[pickerView.selectedRow(inComponent: .zero)]
    }
}

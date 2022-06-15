//
//  ProductListView.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

private typealias Module = ProductListModule
private typealias View = Module.View

extension Module {
    final class View: UIView {
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
        makeConstraints()
    }

    private func makeConstraints() {
    }
}

extension View: Module.ViewOutput { }

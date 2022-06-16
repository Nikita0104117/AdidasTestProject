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
    final class View: UIView, Module.ViewOutput {
        // MARK: - UI Elements
        private(set) lazy var productTableView: UITableView = build(.init(frame: .zero, style: .plain)) {
            $0.separatorStyle = .none

            $0.register(ProductTableViewCell.self)
        }

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
        addSubview(productTableView)

        makeConstraints()
    }

    private func makeConstraints() {
        productTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

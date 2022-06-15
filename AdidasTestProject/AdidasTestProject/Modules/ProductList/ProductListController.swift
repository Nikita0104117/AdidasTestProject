//
//  ProductListController.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule
private typealias Controller = Module.Controller

extension Module {
    final class Controller: UIViewController {
        // MARK: - Dependencies
        var output: ControllerOutput?
        var viewOutput: (UIView & ViewOutput)?

        // MARK: - Properties
        private lazy var searchController: UISearchController = build(
            .init(searchResultsController: nil)
        ) {
            $0.searchResultsUpdater = self
        }

        private lazy var rightBarItem: UIBarButtonItem = build(
            .init(title: "Save All to DB", style: .plain, target: self, action: #selector(rightBarItemTap))

        ) {
            $0.tintColor = AppColors.blue.color
        }

        // MARK: - Init
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() { super.init(nibName: nil, bundle: nil) }

        // MARK: - Lifecycle
        override func loadView() {
            super.loadView()

            self.view = viewOutput
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            commonSetup()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            output?.willAppear()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            output?.didAppear()
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)

            output?.didDisappear()
        }
    }
}

private extension Controller {
    private func commonSetup() {
        title = AppLocale.ProductList.title

        navigationCommonSetup()
        setTableViewDelegate()
    }

    private func navigationCommonSetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = rightBarItem
    }

    @objc private func rightBarItemTap() {
        output?.rightBarItemTap()
    }

    // MARK: - Setup Delegates
    private func setTableViewDelegate() {
        viewOutput?.productTableView.delegate = self
        viewOutput?.productTableView.dataSource = self
    }
}

extension Controller: Module.ControllerInput {
    func reloadData() {
        DispatchQueue.main.async() { [weak self] in
            self?.viewOutput?.productTableView.reloadData()
        }
    }
}

extension Controller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        86
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reusebleId, for: indexPath) as? ProductTableViewCell,
            let product = output?.getProduct(indexPath.item)
        else { return .init() }

        cell.configurate(product)

        return cell
    }
}

extension Controller: UITableViewDelegate { }

extension Controller: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        output?.searchProduct(searchText)
    }
}

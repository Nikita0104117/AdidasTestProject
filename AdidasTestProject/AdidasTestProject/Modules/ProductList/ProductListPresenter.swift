//
//  ProductListPresenter.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies
        weak var controller: ControllerInput?

        var interactor: InteractorInput!
        var router: RouterInput!

        var originDataSource: [ProductEntity] = [] {
            didSet {
                dataSource = originDataSource
            }
        }

        var dataSource: [ProductEntity] = [] {
            didSet {
                controller?.reloadData()
            }
        }

        required init() { }
    }
}

private extension Presenter { }

extension Presenter: Module.ControllerOutput {
    func rightBarItemTap() {
        controller?.showActivity()
        interactor?.saveAllToDB()
    }

    func didAppear() {
        controller?.showActivity()
        interactor?.getProducts()
    }

    var numberOfRows: Int {
        dataSource.count
    }

    func getProduct(_ index: Int) -> ProductEntity {
        dataSource[index]
    }

    func searchProduct(_ searchText: String) {
        if searchText.isEmpty {
            dataSource = originDataSource
            return
        }

        dataSource = originDataSource.filter {
            $0.name?.lowercased().contains(searchText.lowercased()) ?? false
            || $0.descriptionText?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
}

extension Presenter: Module.InteractorOutput {
    func success() {
        controller?.hideActivity()
        controller?.showNetworking(info: AppLocale.General.success)
    }

    func offlineMode() {
        controller?.hideActivity()
        controller?.showNetworking(info: AppLocale.General.offlinemode)
    }

    func successGetProducts(_ products: [ProductEntity]) {
        controller?.hideActivity()
        originDataSource = products
    }

    func failure(error: String) {
        controller?.hideActivity()
        controller?.showNetworking(error: error)
    }
}

//
//  ProductListModule.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ProductListModule {
    typealias ModuleAssemblying = ProductListAssemblyProtocol
    typealias ControllerInput = ProductListControllerInputProtocol
    typealias ControllerOutput = ProductListControllerOutputProtocol
    typealias ViewOutput = ProductListViewOutputProtocol
    typealias InteractorInput = ProductListInteractorInputProtocol
    typealias InteractorOutput = ProductListInteractorOutputProtocol
    typealias RouterInput = ProductListRouterInputProtocol
}

// MARK: - Assembly
protocol ProductListAssemblyProtocol: BaseAssemblyProtocol { }

// MARK: - Controller
protocol ProductListControllerInputProtocol: BaseControllerInput {
    func reloadData()
}

protocol ProductListControllerOutputProtocol: BaseControllerOutput {
    var numberOfRows: Int { get }

    func getProduct(_ index: Int) -> ProductEntity
    func selectedProduct(_ index: Int)
    func searchProduct(_ searchText: String)

    func rightBarItemTap()
}

// MARK: - View
protocol ProductListViewOutputProtocol {
    var productTableView: UITableView { get }
}

// MARK: - Interactor
protocol ProductListInteractorInputProtocol {
    func getProducts()
    func saveAllToDB()
}

protocol ProductListInteractorOutputProtocol: AnyObject {
    func successGetProducts(_ products: [ProductEntity])
    func offlineMode()
    func failure(error: String)
    func success()
}

// MARK: - Router
protocol ProductListRouterInputProtocol {
    func goToDetailScreen(with product: ProductEntity)
}

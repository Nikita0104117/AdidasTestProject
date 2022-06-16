//
//  ProductListInteractor.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies
        weak var output: InteractorOutput?

        let dataBaseManager: DBProtocol
        let productService: ProductService

        required init(dataBaseManager: DBProtocol, productService: ProductService) {
            self.dataBaseManager = dataBaseManager
            self.productService = productService
        }
    }
}

extension Interactor {
    private func saveProductToDB(_ products: [ProductEntity]) {
        dataBaseManager.saveProductsToDB(products: products)
    }

    private func getProductsFromDB() {
        dataBaseManager.getProductsFromDB { [weak self] data in
            self?.output?.successGetProducts(Array(data))
        }
    }

    private var isConnectedToInternet: Bool {
        RestClient.isConnectedToInternet()
    }
}

extension Interactor: Module.InteractorInput {
    func saveAllToDB() {
        if !isConnectedToInternet {
            output?.offlineMode()
            return
        }

        dataBaseManager.downloadAllDataAndSave { [weak self] in
            self?.output?.success()
        }
    }

    func getProducts() {
        if !isConnectedToInternet {
            output?.offlineMode()
            getProductsFromDB()
            return
        }

        productService.getProducts { [weak self] result in
            switch result {
                case .success(let data):
                    self?.saveProductToDB(data)
                    self?.output?.successGetProducts(data)
                case .failure(let error):
                    self?.output?.failure(error: error.localizedDescription)
            }
        }
    }
}

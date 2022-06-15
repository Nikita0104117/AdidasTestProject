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

        let productService: ProductService

        required init(productService: ProductService) {
            self.productService = productService
        }
    }
}

extension Interactor {
    private func saveProductToDB(_ products: [ProductEntity]) {
        let products: [DBProductModel] = products.map { .init($0) }
        DBProductModel.realm.addOrUpdate(object: products)
    }

    private func getProductsFromDB() {
        DBProductModel.realm.fetchWith { [weak self] data in
            self?.output?.successGetProducts(Array(data))
        }
    }

    private var isConnectedToInternet: Bool {
        RestClient.isConnectedToInternet()
    }
}

extension Interactor: Module.InteractorInput {
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

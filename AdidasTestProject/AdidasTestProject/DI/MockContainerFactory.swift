//
//  MockContainerFactory.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Macaroni

class MockContainerFactory {
    // MARK: - Storages
    private lazy var userDefaultsStore = UserDefaultsStore()
    private lazy var keychainStore = KeychainStore()

    // MARK: - Managers

    // MARK: - Modules
    private lazy var productListAssembly: ProductListModule.ModuleAssembly = .init()

    // MARK: - Services
    private lazy var productService: ProductService = MockProductService()
    private lazy var reviewService: ReviewService = MockReviewService()

    func build() -> Container {
        let container = Container()

        // MARK: - Storages
        container.register { [userDefaultsStore] () -> StoreProtocol in userDefaultsStore }
        container.register { [keychainStore] () -> StoreProtocol in keychainStore }

        // MARK: - Managers

        // MARK: - Modules
        container.register { [productListAssembly] () -> ProductListModule.ModuleAssemblying in productListAssembly }

        // MARK: - Services
        container.register { [productService] () -> ProductService in productService }
        container.register { [reviewService] () -> ReviewService in reviewService }

        return container
    }
}

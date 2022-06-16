//
//  RestContainerFactory.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Macaroni

class RestContainerFactory {
    let baseProductURL: String
    let baseReviewURL: String

    init(
        baseProductURL: String,
        baseReviewURL: String
    ) {
        self.baseProductURL = baseProductURL
        self.baseReviewURL = baseReviewURL
    }

    // MARK: - Storages
    private lazy var userDefaultsStore = UserDefaultsStore()
    private lazy var keychainStore = KeychainStore()

    // MARK: - Managers
    private lazy var dataBaseManager: DataBaseManager = .init(productService: productService, reviewService: reviewService)

    // MARK: - Modules
    private lazy var productListAssembly: ProductListModule.ModuleAssembly = .init()
    private lazy var productDetailAssembly: ProductDetailModule.ModuleAssembly = .init()

    // MARK: - Session
    private lazy var restProductClient = RestClient(baseURL: baseProductURL)
    private lazy var restReviewClient = RestClient(baseURL: baseReviewURL)

    // MARK: - Services
    private lazy var productService: ProductService = RestProductService(restClient: restProductClient)
    private lazy var reviewService: ReviewService = RestReviewService(restClient: restReviewClient)

    func build() -> Container {
        let container = Container()

        // MARK: - Storages
        container.register { [userDefaultsStore] () -> StoreProtocol in userDefaultsStore }
        container.register { [keychainStore] () -> StoreProtocol in keychainStore }

        // MARK: - Managers
        container.register { [dataBaseManager] () -> DBProtocol in dataBaseManager }

        // MARK: - Modules
        container.register { [productListAssembly] () -> ProductListModule.ModuleAssemblying in productListAssembly }
        container.register { [productDetailAssembly] () -> ProductDetailModule.ModuleAssemblying in productDetailAssembly }

        // MARK: - Services
        container.register { [productService] () -> ProductService in productService }
        container.register { [reviewService] () -> ReviewService in reviewService }

        return container
    }
}

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

    // MARK: - Modules
    private lazy var productListAssembly: ProductListModule.ModuleAssembly = .init()

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

        // MARK: - Modules
        container.register { [productListAssembly] () -> ProductListModule.ModuleAssemblying in productListAssembly }

        // MARK: - Services
        container.register { [productService] () -> ProductService in productService }
        container.register { [reviewService] () -> ReviewService in reviewService }

        return container
    }
}
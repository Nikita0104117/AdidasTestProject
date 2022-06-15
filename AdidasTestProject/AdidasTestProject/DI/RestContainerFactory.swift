//
//  RestContainerFactory.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Macaroni

class RestContainerFactory {
    let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    // MARK: - Storages
    private lazy var userDefaultsStore = UserDefaultsStore()
    private lazy var keychainStore = KeychainStore()

    // MARK: - Managers


    // MARK: - Modules


    // MARK: - Session
    private lazy var restClient = RestClient(baseURL: baseURL)

    // MARK: - Services

    func build() -> Container {
        let container = Container()

        // MARK: - Storages
        container.register { [userDefaultsStore] () -> StoreProtocol in userDefaultsStore }
        container.register { [keychainStore] () -> StoreProtocol in keychainStore }

        // MARK: - Managers


        // MARK: - Modules


        // MARK: - Services


        return container
    }
}

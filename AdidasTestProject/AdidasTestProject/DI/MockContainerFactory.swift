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

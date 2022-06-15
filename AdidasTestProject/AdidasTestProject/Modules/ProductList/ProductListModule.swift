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
protocol ProductListControllerInputProtocol: BaseControllerInput { }

protocol ProductListControllerOutputProtocol: BaseControllerOutput { }

// MARK: - View
protocol ProductListViewOutputProtocol { }

// MARK: - Interactor
protocol ProductListInteractorInputProtocol { }

protocol ProductListInteractorOutputProtocol: AnyObject { }

// MARK: - Router
protocol ProductListRouterInputProtocol { }

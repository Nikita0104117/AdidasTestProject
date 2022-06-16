//
//  ProductListAssembly.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = ProductListModule

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var productDetailAssembly: ProductDetailModule.ModuleAssemblying!

        @Injected var dataBaseManager: DBProtocol!
        @Injected var productService: ProductService!

        func assemble() -> UIViewController {
            let controller: Controller = .init()
            let view: View = .init()
            let presenter: Presenter = .init()
            let interactor: Interactor = .init(dataBaseManager: dataBaseManager, productService: productService)
            let router: Router = .init(productDetailAssembly: productDetailAssembly)

            controller.output = presenter
            controller.viewOutput = view

            presenter.controller = controller
            presenter.router = router
            presenter.interactor = interactor

            interactor.output = presenter

            router.viewController = controller

            return controller
        }
    }
}

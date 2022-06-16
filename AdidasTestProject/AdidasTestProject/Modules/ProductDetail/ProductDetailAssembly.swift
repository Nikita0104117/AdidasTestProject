//
//  ProductDetailAssembly.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 16.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = ProductDetailModule

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var dataBaseManager: DBProtocol!
        @Injected var reviewService: ReviewService!

        var product: ProductEntity?

        func assemble() -> UIViewController {
            let controller: Controller = .init()
            let view: View = .init()
            let presenter: Presenter = .init(product: product)
            let interactor: Interactor = .init(dataBaseManager: dataBaseManager, reviewService: reviewService)
            let router: Router = .init()

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

//
//  ProductListAssembly.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        func assemble() -> UIViewController {
            let controller: Controller = .init()
            let view: View = .init()
            let presenter: Presenter = .init()
            let interactor: Interactor = .init()
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

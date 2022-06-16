//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ___VARIABLE_productName:identifier___Module

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

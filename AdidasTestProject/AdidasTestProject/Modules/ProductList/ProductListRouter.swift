//
//  ProductListRouter.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies
        weak var viewController: UIViewController!

        required init() { }
    }
}

extension Router: Module.RouterInput { }

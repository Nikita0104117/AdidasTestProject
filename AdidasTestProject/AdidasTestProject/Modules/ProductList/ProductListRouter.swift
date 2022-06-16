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

        var productDetailAssembly: ProductDetailModule.ModuleAssemblying

        required init(productDetailAssembly: ProductDetailModule.ModuleAssemblying) {
            self.productDetailAssembly = productDetailAssembly
        }
    }
}

extension Router: Module.RouterInput {
    func goToDetailScreen(with product: ProductEntity) {
        productDetailAssembly.product = product
        viewController.navigationController?.pushViewController(productDetailAssembly.assemble(), animated: true)
    }
}

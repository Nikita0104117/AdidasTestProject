//
//  ProductListInteractor.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies
        weak var output: InteractorOutput!

        required init() { }
    }
}

extension Interactor: Module.InteractorInput { }

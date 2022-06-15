//
//  ProductListPresenter.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ProductListModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies
        weak var controller: ControllerInput?

        var interactor: InteractorInput!
        var router: RouterInput!

        required init() { }
    }
}

private extension Presenter { }

extension Presenter: Module.ControllerOutput { }

extension Presenter: Module.InteractorOutput { }

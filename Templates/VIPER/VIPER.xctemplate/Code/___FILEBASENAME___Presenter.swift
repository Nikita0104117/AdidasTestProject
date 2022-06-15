//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ___VARIABLE_productName:identifier___Module
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

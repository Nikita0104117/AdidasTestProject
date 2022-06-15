//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ___VARIABLE_productName:identifier___Module
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies
        weak var viewController: UIViewController!

        required init() { }
    }
}

extension Router: Module.RouterInput { }

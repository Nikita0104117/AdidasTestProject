//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ___VARIABLE_productName:identifier___Module
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies
        weak var output: InteractorOutput!

        required init() { }
    }
}

extension Interactor: Module.InteractorInput { }

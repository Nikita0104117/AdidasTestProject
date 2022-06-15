//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

private typealias Module = ___VARIABLE_productName:identifier___Module
private typealias View = Module.View

extension Module {
    final class View: UIView {
        // MARK: - Init
        init() {
            super.init(frame: .zero)

            commonSetup()
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }
}

extension View {
    private func commonSetup() {
        makeConstraints()
    }

    private func makeConstraints() {
    }
}

extension View: Module.ViewOutput { }

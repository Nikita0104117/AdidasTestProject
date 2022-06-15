//
//  ProductService.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductService {
    func getProducts(completion: @escaping (Result<[ProductEntity], Error>) -> Void)
}

extension RequestRouter {
    enum Product {
        case getProducts
    }
}

extension RequestRouter.Product: NetworkingRouterProtocol {
    var path: Endpoint {
        switch self {
            case .getProducts:
                return "product"
        }
    }
}

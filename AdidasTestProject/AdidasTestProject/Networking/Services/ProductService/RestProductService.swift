//
//  RestProductService.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct RestProductService: BaseRestService {
    let restClient: NetworkingSessionProtocol
}

extension RestProductService: ProductService {
    func getProducts(completion: @escaping (Result<[ProductEntity], Error>) -> Void) {
        guard
            let request = restClient.request(RequestRouter.Product.getProducts)
        else {
            completion(.failure(URLError(.badURL)))
            return
        }

        request.responseData { [restClient] response in
            switch response.result {
                case .success(let data):
                    guard
                        let object: [ResponseModels.ProductModel] = restClient.objectfromData(data)
                    else {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }

                    completion(.success(object))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

//
//  MockProductService.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 15.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct MockProductService: ProductService {
    func getProducts(completion: @escaping (Result<[ProductEntity], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(ResponseModels.ProductModel.mockData))
        }
    }
}

private extension ResponseModels.ProductModel {
    static var mockData: [Self] {
        [
            .init(id: "test1", name: "Test_name", descriptionText: "Test_description", currency: "$", price: 101.01, imgUrl: "testurl"),
            .init(id: "test2", name: "Test_name", descriptionText: "Test_description", currency: "$", price: 101.01, imgUrl: "testurl"),
            .init(id: "test3", name: "Test_name", descriptionText: "Test_description", currency: "$", price: 101.01, imgUrl: "testurl"),
            .init(id: "test4", name: "Test_name", descriptionText: "Test_description", currency: "$", price: 101.01, imgUrl: "testurl"),
            .init(id: "test5", name: "Test_name", descriptionText: "Test_description", currency: "$", price: 101.01, imgUrl: "testurl"),
            .init(id: "test6", name: "Test_name", descriptionText: "Test_description", currency: "$", price: 101.01, imgUrl: "testurl"),
        ]
    }
}

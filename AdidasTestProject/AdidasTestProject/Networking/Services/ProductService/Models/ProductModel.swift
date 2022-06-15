//
//  ProductModel.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Foundation

extension ResponseModels {
    struct ProductModel: Decodable, ProductEntity {
        var id: String?
        var name: String?
        var descriptionText: String?
        var currency: String?
        var price: Float?
        var imgUrl: String?

        enum CodingKeys: String, CodingKey {
            case id, name, currency, price, imgUrl
            case descriptionText = "description"
        }
    }
}

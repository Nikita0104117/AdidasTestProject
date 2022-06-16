//
//  ReviewModel.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Foundation

extension ResponseModels {
    struct ReviewModel: Decodable, ReviewEntity {
        var productId: String?
        var locale: String?
        var rating: Int?
        var text: String?
    }
}

extension RequestModels {
    struct ReviewModel: Encodable, ReviewEntity {
        var productId: String?
        var locale: String?
        var rating: Int?
        var text: String?
    }
}

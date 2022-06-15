//
//  Product.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Foundation

protocol ProductEntity {
    var id: String? { get set }
    var name: String? { get set }
    var descriptionText: String? { get set }
    var currency: String? { get set }
    var price: Float? { get set }
    var imgUrl: String? { get set }
}

extension ProductEntity {
    var priceText: String {
        "\(String(format: "%.2f", price ?? 0.0))\(currency ?? "")"
    }
}

protocol ReviewEntity {
    var productId: String? { get set }
    var locale: String? { get set }
    var rating: Int? { get set }
    var text: String? { get set }
}

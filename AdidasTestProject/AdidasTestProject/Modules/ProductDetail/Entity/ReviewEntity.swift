//
//  ReviewEntity.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 16.06.2022.
//

protocol ReviewEntity {
    var productId: String? { get set }
    var locale: String? { get set }
    var rating: Int? { get set }
    var text: String? { get set }
}

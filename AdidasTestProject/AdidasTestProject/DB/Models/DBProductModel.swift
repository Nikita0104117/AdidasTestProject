//
//  DBProductModel.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 15.06.2022.
//

import Foundation
import RealmSwift

class DBProductModel: Object, RealmDataStore, ProductEntity {
    static var realm: RealmManager<DBProductModel> = .init()

    @Persisted(primaryKey: true) var id: String?
    @Persisted var name: String?
    @Persisted var descriptionText: String?
    @Persisted var currency: String?
    @Persisted var price: Float?
    @Persisted var imgUrl: String?

    convenience init(_ value: ProductEntity) {
        self.init()

        self.id = value.id
        self.name = value.name
        self.descriptionText = value.descriptionText
        self.currency = value.currency
        self.price = value.price
        self.imgUrl = value.imgUrl
    }
}

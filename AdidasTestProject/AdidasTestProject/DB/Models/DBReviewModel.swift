//
//  DBReviewModel.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 16.06.2022.
//

import Foundation
import RealmSwift

class DBReviewModel: Object, RealmDataStore, ReviewEntity {
    static var realm: RealmManager<DBReviewModel> = .init()

    @Persisted(primaryKey: true) var id: String?
    @Persisted var productId: String?
    @Persisted var locale: String?
    @Persisted var rating: Int?
    @Persisted var text: String?

    convenience init(_ value: ReviewEntity) {
        self.init()

        self.id = UUID().uuidString
        self.productId = value.productId
        self.locale = value.locale
        self.rating = value.rating
        self.text = value.text
    }
}

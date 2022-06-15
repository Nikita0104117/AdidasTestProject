//
//  GlobalDataBaseManager.swift
//  AdidasTestProject
//
//  Created by Nikita Omelchenko on 16.06.2022.
//

import Foundation

protocol DBProtocol {
    func saveProductsToDB(products: [ProductEntity])
    func saveReviewsToDB(reviews: [ReviewEntity])
    func getProductsFromDB(completion: @escaping ([ProductEntity]) -> Void)
    func getReviewsFromDB(productId: String, completion: @escaping ([ReviewEntity]) -> Void)
    func downloadAllDataAndSave(completion: @escaping () -> Void)
}

class DataBaseManager: DBProtocol {
    let productService: ProductService
    let reviewService: ReviewService

    init(productService: ProductService, reviewService: ReviewService) {
        self.productService = productService
        self.reviewService = reviewService
    }

    private func getReviews(productId: String, completion: @escaping () -> Void) {
        reviewService.getReviews(productId: productId) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.saveReviewsToDB(reviews: data)
                    completion()
                case .failure:
                    break
            }
        }
    }

    private func getProducts(completion: @escaping ([String]) -> Void) {
        productService.getProducts { [weak self] result in
            switch result {
                case .success(let data):
                    self?.saveProductsToDB(products: data)
                    completion(data.map { $0.id ?? "" })
                case .failure:
                    break
            }
        }
    }

    public func saveProductsToDB(products: [ProductEntity]) {
        let products: [DBProductModel] = products.map { .init($0) }
        DBProductModel.realm.addOrUpdate(object: products)
    }

    public func saveReviewsToDB(reviews: [ReviewEntity]) {
        let reviews: [DBReviewModel] = reviews.map { .init($0) }
        DBReviewModel.realm.addOrUpdate(object: reviews)
    }

    public func getProductsFromDB(completion: @escaping ([ProductEntity]) -> Void) {
        DBProductModel.realm.fetchWith { data in
            completion(Array(data))
        }
    }

    public func getReviewsFromDB(productId: String, completion: @escaping ([ReviewEntity]) -> Void) {
        DBReviewModel.realm.fetchWith(condition: "productId == \(productId)") { data in
            completion(Array(data))
        }
    }

    public func downloadAllDataAndSave(completion: @escaping () -> Void) {
        let mainGroup: DispatchGroup = .init()
        mainGroup.enter()
        getProducts { [weak self] productsId in
            mainGroup.leave()
            for element in productsId {
                mainGroup.enter()
                self?.getReviews(productId: element) {
                    mainGroup.leave()
                }
            }
        }

        mainGroup.notify(queue: .main) {
            completion()
        }
    }
}

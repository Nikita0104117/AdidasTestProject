//
//  ProductDetailModule.swift
//  AdidasTestProject
//
//  Created Nikita Omelchenko on 16.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ProductDetailModule {
    typealias ModuleAssemblying = ProductDetailAssemblyProtocol
    typealias ControllerInput = ProductDetailControllerInputProtocol
    typealias ControllerOutput = ProductDetailControllerOutputProtocol
    typealias ViewOutput = ProductDetailViewOutputProtocol
    typealias InteractorInput = ProductDetailInteractorInputProtocol
    typealias InteractorOutput = ProductDetailInteractorOutputProtocol
    typealias RouterInput = ProductDetailRouterInputProtocol
}

// MARK: - Assembly
protocol ProductDetailAssemblyProtocol: BaseAssemblyProtocol {
    var product: ProductEntity? { get set }
}

// MARK: - Controller
protocol ProductDetailControllerInputProtocol: BaseControllerInput {
    func feelProductInfo(_ product: ProductEntity)
    func reloadReviewData(_ reviews: [ReviewEntity])
}

protocol ProductDetailControllerOutputProtocol: BaseControllerOutput {
    func tapSendReview(rating: Int, text: String)
}

// MARK: - View
protocol ProductDetailViewOutputProtocol {
    var productImageView: UIImageView { get }
    var titleLabel: UILabel { get }
    var subTitleLabel: UILabel { get }
    var priceLabel: UILabel { get }
    var reviewStackView: UIStackView { get }
    var sendReviewView: MakeReviewView { get }
}

// MARK: - Interactor
protocol ProductDetailInteractorInputProtocol {
    func getReviews(_ productId: String)
    func sendReview(rating: Int, text: String, productId: String?, locale: String?)
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func successGetReviews(_ reviews: [ReviewEntity])
    func successSendReviews(_ review: ReviewEntity)
    func offlineMode()
    func failure(error: String)
}

// MARK: - Router
protocol ProductDetailRouterInputProtocol { }

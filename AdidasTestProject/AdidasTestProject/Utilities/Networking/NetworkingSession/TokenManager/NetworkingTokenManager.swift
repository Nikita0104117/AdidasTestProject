//
//  TokenManager.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 19.10.2021.
//

import Foundation
import Alamofire
import JWTDecode

final class TokenManager {
    typealias AuthCredential = OAuthAuthenticator.OAuthCredential

    enum Keys: String {
        case accessToken
        case refreshToken
    }

    struct TokensModel: Codable {
        var accessToken: String?
        var refreshToken: String?
    }

    private let keychainStore: StoreProtocol
    private let rest: NetworkingSessionProtocol

    private var authCredential: AuthCredential? {
        guard
            let accessToken: String = keychainStore.get(.accessToken),
            let expirationDate: Date = expirationDate(token: accessToken)
        else {
            return nil
        }

        return AuthCredential(
            accessToken: accessToken,
            refreshToken: keychainStore.get(.refreshToken) ?? "",
            expiration: expirationDate
        )
    }

    init(rest: NetworkingSessionProtocol, keychainStore: StoreProtocol) {
        self.rest = rest
        self.keychainStore = keychainStore

        self.commonSetup()
    }

    private func commonSetup() {
//        self.rest.authDelegate = self
        self.rest.authCredential = authCredential
    }

    private func configAuthCredential(tokensModel: TokensModel) -> AuthCredential? {
        guard
            let accessToken = tokensModel.accessToken,
            let expirationDate = expirationDate(token: accessToken)
        else {
            return nil
        }

        let authCredential = AuthCredential(
            accessToken: accessToken,
            refreshToken: tokensModel.refreshToken ?? "",
            expiration: expirationDate
        )

        self.keychainStore.set(accessToken, key: .accessToken)
        self.keychainStore.set(tokensModel.refreshToken, key: .refreshToken)

        return authCredential
    }

    private func expirationDate(token: String) -> Date? {
        do {
            let jwt = try decode(jwt: token)
            return jwt.expiresAt
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    public func refreshTokenRequest(refreshToken: String?, completion: @escaping (Result<AuthCredential, Error>) -> Void) {
//        guard
//            let refreshToken = refreshToken,
//            let isExpired = try? decode(jwt: refreshToken).expired,
//            !isExpired,
//            let request = rest.request(TokenRouter.refreshToken(.init(refreshToken: refreshToken)) as? NetworkingRouterProtocol)
//        else {
//            completion(.failure(URLError(.cancelled)))
//            return
//        }
//
//        request.responseData { [weak self] response in
//            guard let self = self else { return }
//
//            switch response.result {
//                case .success(let data):
//                    guard
//                        let tokensModel: TokensModel = self.rest.objectfromData(data),
//                        let authCredential = self.configAuthCredential(tokensModel: tokensModel)
//                    else {
//                        completion(.failure(URLError(.badServerResponse)))
//                        return
//                    }
//
//                    completion(.success(authCredential))
//                    return
//
//                case .failure(let error):
//                    completion(.failure(error))
//                    return
//            }
//        }
    }
}

// MARK: - Token Protocol
extension TokenManager: TokenProtocol {
    func updateToken(_ tokens: TokensModel?) {
        guard
            let tokens = tokens
        else {
            rest.authCredential = nil
            return
        }

        keychainStore.set(tokens.accessToken, key: .accessToken)
        keychainStore.set(tokens.refreshToken, key: .refreshToken)

        rest.authCredential = self.authCredential
    }
}

// MARK: - Private Store Extension
private extension StoreProtocol {
    func get<T: Decodable>(_ key: TokenManager.Keys) -> T? {
        self.get(key.rawValue)
    }

    func set<T: Encodable>(_ value: T?, key: TokenManager.Keys) {
        self.set(value, key: key.rawValue)
    }
}

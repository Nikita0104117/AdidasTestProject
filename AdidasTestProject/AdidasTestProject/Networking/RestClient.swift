import Foundation
import Alamofire

enum ApiURLsPath: String {
    case baseProdUrl = "https://618d3aa7fe09aa001744060a.mockapi.io/api/"
    case baseStageUrl = ""
}

final class RestClient: NetworkingSession, InterceptorDelegate {
    override init(baseURL: String) {
        super.init(baseURL: baseURL)

        self.interceptorDelegate = self
    }

    func retry(_ request: Request, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

// MARK: - Base Service Protocol
protocol BaseRestService {
    var restClient: NetworkingSessionProtocol { get }
}

// MARK: - OAuth Authenticator Delegate
extension TokenManager: OAuthAuthenticatorDelegate { }

// MARK: - Token Manager Networking Router Protocol
extension TokenManager.TokenRouter: NetworkingRouterProtocol {
    var path: Endpoint { "" }
}

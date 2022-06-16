import Foundation
import Alamofire

enum ApiURLsPath: String {
    case baseProductUrl = "http://localhost:3001/"
    case baseReviewUrl = "http://localhost:3002/"
}

final class RestClient: NetworkingSession, InterceptorDelegate {
    override init(baseURL: String) {
        super.init(baseURL: baseURL)

        self.interceptorDelegate = self
    }

    class func isConnectedToInternet() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
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

// MARK: - Response Models
enum ResponseModels { }

// MARK: - Request Models
enum RequestModels { }

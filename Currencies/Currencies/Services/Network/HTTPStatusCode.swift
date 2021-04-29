// MARK: - Follow this link https://gist.github.com/ollieatkinson/322338df8a5220d649ac01ff11e7de12 to see original
public enum HTTPStatusCode: Int {
    /// The response class representation of status codes, these get grouped by their first digit.
    enum ResponseType {
        /// - informational: This class of status code indicates a provisional response, consisting only of the Status-Line and optional headers, and is terminated by an empty line.
        case informational
        
        /// - success: This class of status codes indicates the action requested by the client was received, understood, accepted, and processed successfully.
        case success
        
        /// - redirection: This class of status code indicates the client must take additional action to complete the request.
        case redirection
        
        /// - clientError: This class of status code is intended for situations in which the client seems to have erred.
        case clientError
        
        /// - serverError: This class of status code indicates the server failed to fulfill an apparently valid request.
        case serverError
        
        /// - undefined: The class of the status code cannot be resolved.
        case undefined
    }
    
    //
    // Success - 2xx
    //
    
    /// - ok: Standard response for successful HTTP requests.
    case ok = 200
    
    //
    // Client Error - 4xx
    //
    
    /// - badRequest: The server cannot or will not process the request due to an apparent client error.
    case badRequest = 400
    
    /// - unauthorized: Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided.
    case unauthorized = 401
    
    /// - unprocessableEntity: The request was well-formed but was unable to be followed due to semantic errors.
    case unprocessableEntity = 422
    
    /// - upgradeRequired: The client app should update to a newer version that is available on the App Store.
    case updateRequired = 426
    
    /// - unavailableForLegalReasons: A server operator has received a legal demand to deny access to a resource or to a set of resources that includes the requested resource.
    case unavailableForLegalReasons = 451
    
    //
    // Server Error - 5xx
    //
    
    /// - internalServerError: A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
    case internalServerError = 500
    
    /// - notImplemented: The server either does not recognize the request method, or it lacks the ability to fulfill the request.
    case notImplemented = 501
    
    /// - badGateway: The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway = 502
    
    /// - serviceUnavailable: The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.
    case serviceUnavailable = 503
    
    /// The class (or group) which the status code belongs to.
    var responseType: ResponseType {
        switch self.rawValue {
        case 100..<200:
            return .informational
        case 200..<300:
            return .success
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .undefined
        }
    }
}

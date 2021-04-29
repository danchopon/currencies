import Foundation
import Moya

enum NetworkError: Error {
    /// Indicates a response failed to map to an image.
    case imageMapping(HTTPURLResponse?)

    /// Indicates a response failed to map to a JSON structure.
    case jsonMapping(HTTPURLResponse?)

    /// Indicates a response failed to map to a String.
    case stringMapping(HTTPURLResponse?)

    /// Indicates a response failed to map to a Decodable object.
    case objectMapping(Swift.Error, HTTPURLResponse?)

    /// Indicates that Encodable couldn't be encoded into Data
    case encodableMapping(Swift.Error)

    /// Indicates a response failed with an invalid HTTP status code.
    case statusCode(Response)

    /// Indicates a response failed due to an underlying `Error`.
    case underlying(Swift.Error, HTTPURLResponse?)

    /// Indicates that an `Endpoint` failed to map to a `URLRequest`.
    case requestMapping(String)

    /// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
    case parameterEncoding(Swift.Error)
}

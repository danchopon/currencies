//
//  CurrenciesAPI.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 30/4/21.
//

import Moya

enum CurrenciesAPI {
    case latest
}

extension CurrenciesAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.configuration(.baseUrlAPI))!
    }
    
    var path: String {
        switch self {
        case .latest:
            return "/latest"
        }
    }
    
    var method: Method {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .latest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

//
//  Environment.swift
//  Currencies
//
//  Created by Daniyar Erkinov on 29/4/21.
//

import Foundation

enum PlistKey: String, CaseIterable {
    case baseUrlAPI = "APP_API_BASE_URL"
}

enum Environment {
    fileprivate static var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
    
    public static func configuration(_ key: PlistKey) -> String {
        guard let configValue = infoDict[key.rawValue] as? String else {
            fatalError("Couldn't find such string for '\(key.rawValue)' key in plist configuration file")
        }
        return configValue
    }
}

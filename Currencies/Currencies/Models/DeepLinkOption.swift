import Foundation

struct DeepLinkURLConstants {
    static let AllCurrencies = "allCurrencies"
    static let MyCurrencies = "myCurrencies"
    static let CurrencyDetails = "currencyDetails"
}

enum DeepLinkOption {
  
  case allCurrencies
  case myCurrencies
  case currencyDetails
  
  static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
      let url = userActivity.webpageURL,
      let _ = URLComponents(url: url, resolvingAgainstBaseURL: true) {
      //TODO: extract string and match with DeepLinkURLConstants
    }
    return nil
  }
  
  static func build(with dict: [String : AnyObject]?) -> DeepLinkOption? {
    guard let id = dict?["launch_id"] as? String else { return nil }
    
    switch id {
      case DeepLinkURLConstants.AllCurrencies: return .allCurrencies
      case DeepLinkURLConstants.MyCurrencies: return .myCurrencies
      case DeepLinkURLConstants.CurrencyDetails: return .currencyDetails
      default: return nil
    }
  }
}

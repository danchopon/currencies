import Foundation

extension Decodable {
    static func parse(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }
    
    static func parse(with decoder: JSONDecoder = JSONDecoder(), from response: Any?) -> Self? {
        
        guard let jsonValue = response else {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: jsonValue) else {
            return nil
        }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(Self.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

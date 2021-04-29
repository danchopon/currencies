import Moya

final class NetworkManager {
    var provider: MoyaProvider<MultiTarget>
    lazy var customDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    func request<M: Decodable>(_ api: MultiTarget, for model: M.Type, completion: @escaping ((Result<M, NetworkError>) -> Void)) {
        provider.request(api) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let successResponse = try response.filterSuccessfulStatusCodes()
                    let mappedModel = try successResponse.map(M.self, using: self.customDecoder)
                    completion(.success(mappedModel))
                } catch {
                    completion(.failure(self.process(error as! MoyaError, model: M.self)))
                }
            case .failure(let error):
                return completion(.failure(self.process(error, model: M.self)))
            }
        }
    }
    
    func request(_ api: MultiTarget, completion: @escaping ((Result<Any, NetworkError>) -> Void)) {
        provider.request(api) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let successResponse = try response.filterSuccessfulStatusCodes()
                    let mappedModel = try successResponse.mapJSON(failsOnEmptyData: false)
                    completion(.success(mappedModel))
                } catch {
                    completion(.failure(self.process(error as! MoyaError)))
                }
            case .failure(let error):
                return completion(.failure(self.process(error)))
            }
        }
    }
    
    func request(_ api: MultiTarget, progress: ProgressBlock?, completion: @escaping ((Result<Any, NetworkError>) -> Void)) {
        provider.request(api, progress: progress) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let successResponse = try response.filterSuccessfulStatusCodes()
                    let mappedModel = try successResponse.mapJSON(failsOnEmptyData: false)
                    completion(.success(mappedModel))
                } catch {
                    completion(.failure(self.process(error as! MoyaError)))
                }
            case .failure(let error):
                return completion(.failure(self.process(error)))
            }
        }
    }

    
    private func process(_ error: MoyaError, model: Decodable.Type? = nil) -> NetworkError {
        switch error {
        case .statusCode(let response):
            return .statusCode(response)
        case .imageMapping(let response):
            return .imageMapping(response.response)
        case .jsonMapping(let response):
            return .jsonMapping(response.response)
        case .stringMapping(let response):
            return .stringMapping(response.response)
        case let .objectMapping(error, response):
            if let model = model, let error = error as? DecodingError {
                CURError.debugPrintDecodingError(error, model: model)
            }
            return .objectMapping(error, response.response)
        case .encodableMapping(let error):
            return .encodableMapping(error)
        case let .underlying(error, response):
            return .underlying(error, response?.response)
        case .requestMapping(let url):
            return .requestMapping(url)
        case .parameterEncoding(let error):
            return .parameterEncoding(error)
        }
    }
}


import Foundation

final class NetworkClientImpl: NetworkClient {
    
    // MARK: - Properties
    private let urlSession: URLSession = URLSession(configuration: .default)
    
    // MARK: - Dependencies
    //private let userDefaults: UserDefaults
    private let requestBuilder: RequestBuilder
    
    // MARK: - Init
    init(
        //userDefaults: UserDefaults = UserDefaults.standard,
        requestBuilder: RequestBuilder = RequestBuilderImpl()
    ) {
        //self.userDefaults = userDefaults
        self.requestBuilder = requestBuilder
    }
    
    // MARK: - NetworkClient
    func send<Request: NetworkRequest>(
        request: Request
    ) async -> Result<Request.Response, NetworkError> {
        
        switch requestBuilder.build(request: request) {
        case let .success(urlRequest):
            return await send(
                urlRequest: urlRequest,
                responseConverter: request.responseConverter
            )
            
        case let .failure(error):
            return .failure(error)
            
        }
    }
    
    func getImageDataFromURL(url: String) async -> Result<Data, NetworkError> {
        URLCache.shared.removeAllCachedResponses()
        do {
            guard let url = URL(string: url) else {
                return .failure(.networkError)
            }
            let request = URLRequest(url: url)
            let (data, response) = try await urlSession.data(for: request)
            return .success(data)
        } catch {
            switch (error as? URLError)?.code {
            case .some(.notConnectedToInternet):
                print("CAAAATCH this ERROR in IMG handling!!!!")
                return .failure(.noInternetConnection)
            case .some(.timedOut):
                return .failure(.timeout)
            default:
                return .failure(.networkError)
            }
        }
    }
    
    // MARK: - Private methods - Send methods
    private func send<Converter: NetworkResponseConverter>(
        urlRequest: URLRequest,
        responseConverter: Converter
    ) async -> Result<Converter.Response, NetworkError> {
        do {
            URLCache.shared.removeCachedResponse(for: urlRequest)
            let (data, response) = try await urlSession.data(for: urlRequest)
            return decodeResponse(from: data, responseConverter: responseConverter)
        } catch {
            switch (error as? URLError)?.code {
            case .some(.notConnectedToInternet):
                print("CATCH INTER CONN")
                return .failure(.noInternetConnection)
            case .some(.timedOut):
                return .failure(.timeout)
            default:
                print("CATCH NETWORK ERROR")
                return .failure(.networkError)
            }
        }
    }
    
    // MARK: - Private methods - Decode methods
    func decodeResponse<Converter: NetworkResponseConverter>(
        from data: Data,
        responseConverter: Converter
    ) -> Result<Converter.Response, NetworkError> {
        if let response = responseConverter.decodeResponse(from: data) {
            print("Decode response")
            return .success(response)
        }
        print("Failll")
        return .failure(.parsingFailure)
    }
}

//// MARK: - Spec
//fileprivate enum Spec {
//    static func responseCacheKey(urlString: String) -> String {
//        "ExpirationTimestamp_\(urlString)"
//    }
//}

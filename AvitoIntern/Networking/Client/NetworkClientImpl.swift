import Foundation

final class NetworkClientImpl: NSObject, NetworkClient {
    
    // MARK: - Properties
    private let urlSession: URLSession = URLSession(configuration: .default)
    
    
    // MARK: - Dependencies
    private let requestBuilder: RequestBuilder
    
    // MARK: - Init
    init(
        requestBuilder: RequestBuilder = RequestBuilderImpl()
    ) {
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
                return .failure(.noInternetConnection)
            case .some(.timedOut):
                return .failure(.timeout)
            default:
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
            return .success(response)
        }
        return .failure(.parsingFailure)
    }
}

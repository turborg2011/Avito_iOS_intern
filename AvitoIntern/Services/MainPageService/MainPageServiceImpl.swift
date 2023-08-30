import UIKit

final class MainPageServiceImpl: MainPageService {
 
    // MARK: - Properties
    private let networkClient: NetworkClient
    
    // MARK: - Dependencies
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - MainPageService
    func advertisments() async -> Result<AdvertismentsResponse, NetworkError> {
        await networkClient.send(request: AdvertismentsRequest())
    }
    
    func uiImageDataFromURL(url: String) async -> Result<Data, NetworkError> {
        await networkClient.getImageDataFromURL(url: url)
    }
}

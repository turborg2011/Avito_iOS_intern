import UIKit

final class DetailPageServiceImpl: DetailPageService {
 
    // MARK: - Properties
    private let networkClient: NetworkClient
    private let id: String
    
    // MARK: - Dependencies
    init(networkClient: NetworkClient, id: String) {
        self.networkClient = networkClient
        self.id = id
    }
    
    // MARK: - MainPageService
    func advertisement() async -> Result<AdvertisementResponse, NetworkError> {
        return await networkClient.send(request: AdvertisementRequest(id: self.id))
    }
    
    func uiImageDataFromURL(url: String) async -> Result<Data, NetworkError> {
        return await networkClient.getImageDataFromURL(url: url)
    }
}

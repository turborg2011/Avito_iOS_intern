import UIKit

final class DetailPageServiceImpl: DetailPageService {
 
    // MARK: - Properties
    private let networkClient: NetworkClient
    private let id: String
    
    // MARK: - Dependencies
    init(networkClient: NetworkClient, id: String) {
        self.networkClient = networkClient
        self.id = id
        
        print("NETW CLIENT CREATED SUCCESSFULLY")
    }
    
    // MARK: - MainPageService
    func advertisement() async -> Result<AdvertisementResponse, NetworkError> {
        print("service detail worked")
        return await networkClient.send(request: AdvertisementRequest(id: self.id))
    }
    
    func uiImageDataFromURL(url: String) async -> Result<Data, NetworkError> {
        print("img url worked")
        return await networkClient.getImageDataFromURL(url: url)
    }
}

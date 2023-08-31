final class AdvertisementRequest: NetworkRequest {
    typealias Response = AdvertisementResponse
    
    let path: String
    
    init(id: String) {
        self.path = "details/\(id).json"
    }
    let httpMethod: HttpMethod = .GET
}

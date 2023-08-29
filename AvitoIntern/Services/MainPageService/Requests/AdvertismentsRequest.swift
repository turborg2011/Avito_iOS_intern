final class AdvertismentsRequest: NetworkRequest {
    typealias Response = AdvertismentsResponse
    
    let path = "main-page.json"
    let httpMethod: HttpMethod = .GET
}

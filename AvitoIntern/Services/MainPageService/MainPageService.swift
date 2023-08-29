protocol MainPageService: AnyObject {
    func advertisments() async -> Result<AdvertismentsResponse, NetworkError>
}

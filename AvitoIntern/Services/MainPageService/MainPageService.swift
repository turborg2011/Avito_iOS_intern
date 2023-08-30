import UIKit

protocol MainPageService: AnyObject {
    func advertisments() async -> Result<AdvertismentsResponse, NetworkError>
    func uiImageDataFromURL(url: String) async -> Result<Data, NetworkError>
}

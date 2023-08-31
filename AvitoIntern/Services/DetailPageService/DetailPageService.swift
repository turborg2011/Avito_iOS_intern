import UIKit

protocol DetailPageService: AnyObject {
    func advertisement() async -> Result<AdvertisementResponse, NetworkError>
    func uiImageDataFromURL(url: String) async -> Result<Data, NetworkError>
}


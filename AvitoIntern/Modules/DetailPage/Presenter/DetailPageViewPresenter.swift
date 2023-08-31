import Foundation
import UIKit

final class DetailPageViewPresenter {
    
    // MARK: - Weak properties
    @MainActor weak var view: DetailPageViewViewInput? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - Dependencies
    private let service: DetailPageService
    private let loaderDisplayable: LoaderDisplayable
    private let messageDisplayable: MessageDisplayable
    private let contentPlaceholderDisplayable: ContentPlaceholderDisplayable
    
    // MARK: - Init
    init(
        service: DetailPageService,
        loaderDisplayable: LoaderDisplayable,
        messageDisplayable: MessageDisplayable,
        contentPlaceholderDisplayable: ContentPlaceholderDisplayable
    ) {
        self.service = service
        self.loaderDisplayable = loaderDisplayable
        self.messageDisplayable = messageDisplayable
        self.contentPlaceholderDisplayable = contentPlaceholderDisplayable
    }
    
    // MARK: - SetUp
    @MainActor private func setUpView() {
        view?.onTopRefresh = { [weak self] in
            self?.proceedToLoadAdvertisement(isRefreshing: true)
        }
        
        view?.onViewDidLoad = { [weak self] in
            self?.proceedToLoadAdvertisement()
        }
    }
    
    // MARK: - Load advertisements
    private func proceedToLoadAdvertisement(isRefreshing: Bool = false) {
        Task {
            await proceedToLoadAdvertisement(isRefreshing: isRefreshing)
        }
    }
    
    private func proceedToLoadAdvertisement(isRefreshing: Bool = false) async {
        let loaderDisplayable = isRefreshing ? nil : loaderDisplayable
        
        await loaderDisplayable?.showLoader()
        let result = await service.advertisement()
        await loaderDisplayable?.hideLoader()
        
        switch result {
        case let .success(response):
            await handleAdvertisementLoading(response, isRefreshing: isRefreshing)
        case let .failure(error):
            await handleAdvertisementLoading(error, isRefreshing: isRefreshing)
        }
        await view?.endRefreshing()
    }
    
    private func handleAdvertisementLoading(_ response: AdvertisementResponse, isRefreshing: Bool = false) async {
        
        let loaderDisplayable = isRefreshing ? nil : loaderDisplayable
        await loaderDisplayable?.showLoader()
        let model = DetailViewModelAdvertisement(id: response.advertisement.id,
                                        title: response.advertisement.title,
                                        price: response.advertisement.price,
                                        location: response.advertisement.location,
                                        image: await imageFromURL(url: response.advertisement.image_url, isRefreshing: isRefreshing),
                                        created_date: response.advertisement.created_date,
                                        description: response.advertisement.description,
                                        email: response.advertisement.email,
                                        phone_number: response.advertisement.phone_number,
                                        address: response.advertisement.address)
        
        await view?.endRefreshing()
        await loaderDisplayable?.hideLoader()
        await view?.display(model: model)
    }
    
    private func handleAdvertisementLoading(_ error: NetworkError, isRefreshing: Bool) async {
        if isRefreshing {
            await messageDisplayable.showMessage(error: error)
            return
        }
        
        await contentPlaceholderDisplayable.showPlaceholder(error: error) { [weak self] in
            self?.proceedToLoadAdvertisement()
        }
    }
    
    func imageFromURL(url: String, isRefreshing: Bool = false) async -> UIImage? {
        let imageData = await service.uiImageDataFromURL(url: url)

        switch imageData {
        case let .success(data):
            return UIImage(data: data)
        case let .failure(error):
            return nil
        }
    }
}

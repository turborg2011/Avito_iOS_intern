import Foundation
import UIKit

final class MainPresenter {
    
    // MARK: - Weak properties
    @MainActor weak var view: MainViewViewInput? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - Dependencies
    private let service: MainPageService
    private let loaderDisplayable: LoaderDisplayable
    private let messageDisplayable: MessageDisplayable
    private let contentPlaceholderDisplayable: ContentPlaceholderDisplayable
    
    // MARK: - Init
    init(
        service: MainPageService,
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
            self?.proceedToLoadAdvertisments(isRefreshing: true)
        }
        
        view?.onViewDidLoad = { [weak self] in
            self?.proceedToLoadAdvertisments()
        }
    }

    // MARK: - Load advertisements
    private func proceedToLoadAdvertisments(isRefreshing: Bool = false) {
        Task {
            await proceedToLoadAdvertisments(isRefreshing: isRefreshing)
        }
    }
    
    private func proceedToLoadAdvertisments(isRefreshing: Bool = false) async {
        let loaderDisplayable = isRefreshing ? nil : loaderDisplayable
        
        await loaderDisplayable?.showLoader()
        let result = await service.advertisments()
        await loaderDisplayable?.hideLoader()
        
        switch result {
        case let .success(response):
            await handleAdvertismentsLoading(response, isRefreshing: isRefreshing)
        case let .failure(error):
            await handleAdvertismentsLoading(error, isRefreshing: isRefreshing)
        }
        
        
        
        await view?.endRefreshing()
    }
    
    private func handleAdvertismentsLoading(_ response: AdvertismentsResponse, isRefreshing: Bool = false) async {
        await view?.setTitle("Advertisments!!!!!!!")
        
        print("RESP AD COUNT === \(response.advertisments.count)")
        
        let loaderDisplayable = isRefreshing ? nil : loaderDisplayable
        await loaderDisplayable?.showLoader()
        let models = await withTaskGroup(of: CollectionViewModel.self, body: { group in
            for advertisement in response.advertisments {
                group.addTask { [weak self] in await
                    CollectionViewModel(
                        id: advertisement.id,
                        data: AdvertismentCellData(
                            id: advertisement.id,
                            title: advertisement.title,
                            price: advertisement.price,
                            location: advertisement.location,
                            image: self?.imageFromURL(url: advertisement.image_url, isRefreshing: isRefreshing),
                            //image: nil,
                            created_date: advertisement.created_date
                        ),
                        cellType: AdvertismentCell.self
                    )
                }
            }
            
            return await group.reduce(into: [CollectionViewModel]()) { partialResult, model in
                partialResult.append(model)
            }
        })
        
        print("MODEL COUNTS IS === \(models.count)")
//        let models = response.advertisments.map {
//            CollectionViewModel(
//                id: $0.id,
//                data: AdvertismentCellData(
//                    id: $0.id,
//                    title: $0.title,
//                    price: $0.price,
//                    location: $0.location,
//                    image: await service.uiImageFromURL(url: $0.image_url),
//                    created_date: $0.created_date
//                ),
//                cellType: AdvertismentCell.self
//            )
//        }
        
        await loaderDisplayable?.hideLoader()
        await view?.endRefreshing()
        await view?.display(models: models)
    }
    
    private func handleAdvertismentsLoading(_ error: NetworkError, isRefreshing: Bool) async {
        if isRefreshing {
            await messageDisplayable.showMessage(error: error)
            return
        }
        
        await contentPlaceholderDisplayable.showPlaceholder(error: error) { [weak self] in
            self?.proceedToLoadAdvertisments()
        }
    }
    
    func imageFromURL(url: String, isRefreshing: Bool = false) async -> UIImage? {
        let imageData = await service.uiImageDataFromURL(url: url)

        switch imageData {
        case let .success(data):
            return UIImage(data: data)
        case let .failure(error):
            return nil
            //await handleAdvertismentsLoading(error, isRefreshing: isRefreshing)
        }
        
        //return nil
    }
}

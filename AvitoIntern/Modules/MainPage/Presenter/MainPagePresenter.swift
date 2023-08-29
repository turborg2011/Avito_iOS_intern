import Foundation

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

    // MARK: - Load company
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
        await view?.endRefreshing()
        
        switch result {
        case let .success(response):
            await handleAdvertismentsLoading(response)
        case let .failure(error):
            await handleAdvertismentsLoading(error, isRefreshing: isRefreshing)
        }
    }
    
    private func handleAdvertismentsLoading(_ response: AdvertismentsResponse) async {
        await view?.setTitle("Advertisments!!!!!!!")
        await view?.display(models: response.advertisments
            .enumerated()
            .map {
                
//                let id: Int
//                let title: String
//                let price: String
//                let location: String
//                let image_url: String
//                let created_date: String
                
                CollectionViewModel(
                    id: $0.element.id,
                    data: AdvertismentCellData(
                        id: $0.element.id,
                        title: $0.element.title,
                        price: $0.element.price,
                        location: $0.element.location,
                        image_url: $0.element.image_url,
                        created_date: $0.element.created_date
                    ),
                    cellType: AdvertismentCell.self
                )
            }
        )
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
}

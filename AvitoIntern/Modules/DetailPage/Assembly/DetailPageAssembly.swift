import UIKit

@MainActor final class DetailPageAssembly {
    func viewController(id: String) -> UIViewController {
        let service = DetailPageServiceImpl(networkClient: NetworkClientImpl(), id: id)
        
        let viewController = DetailPageViewController()
        
        let loaderDisplayable = WeakDelayLoaderDisplayable(loaderDisplayable: viewController)
        
        let messageDisplayable = WeakMessageDisplayable(messageDisplayable: viewController)
        
        let contentPlaceholderDisplayable = WeakContentPlaceholderDisplayable(contentPlaceholderDisplayable: viewController)
        
        let presenter = DetailPageViewPresenter(
            service: service,
            loaderDisplayable: loaderDisplayable,
            messageDisplayable: messageDisplayable,
            contentPlaceholderDisplayable: contentPlaceholderDisplayable
        )
        
        viewController.addDisposeBag(presenter)
        presenter.view = viewController

        return viewController
    }
}



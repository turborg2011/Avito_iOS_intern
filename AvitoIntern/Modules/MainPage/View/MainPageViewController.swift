import UIKit

final class MainViewController:
    BaseViewController,
    MainViewViewInput,
    LoaderDisplayable,
    ContentPlaceholderDisplayable
{
    // MARK: - Subviews
    private let loader = Loader()
    private let collectionView = CollectionView()
    private let contentPlaceholder = ContentPlaceholder()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loader)
        view.addSubview(contentPlaceholder)
        view.addSubview(collectionView)
    }
    
    // MARK: - MainViewViewInput
    var onTopRefresh: (() -> ())? {
        get { collectionView.onTopRefresh }
        set { collectionView.onTopRefresh = newValue }
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func display(models: [CollectionViewModel]) {
        collectionView.display(models: models)
    }
    
    func endRefreshing() {
        collectionView.endRefreshing()
    }
    
    // MARK: - LoaderDisplayable
    func showLoader() {
        loader.isHidden = false
        loader.start()
        view.bringSubviewToFront(loader)
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stop()
        view.sendSubviewToBack(loader)
    }
    
    // MARK: - ContentPlaceholderDisplayable
    func showPlaceholder(model: ContentPlaceholderModel) {
        contentPlaceholder.update(with: model)
        contentPlaceholder.isHidden = false
        view.bringSubviewToFront(contentPlaceholder)
    }
    
    func hidePlaceholder() {
        contentPlaceholder.isHidden = true
        view.sendSubviewToBack(contentPlaceholder)
    }
    
    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.backgroundColor = .white
        loader.frame = view.bounds
        contentPlaceholder.frame = view.bounds
        collectionView.frame = view.bounds
    }
}

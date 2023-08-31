import UIKit

final class DetailPageViewController:
    BaseViewController,
    DetailPageViewViewInput,
    LoaderDisplayable,
    ContentPlaceholderDisplayable {
    
    // MARK: - Subviews
    private let loader = Loader()
    private let contentPlaceholder = ContentPlaceholder()
    private let detailView = DetailView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loader)
        view.addSubview(contentPlaceholder)
        view.addSubview(detailView)
    }
    
    // MARK: - MainViewViewInput
    var onTopRefresh: (() -> ())? {
        get { detailView.onTopRefresh }
        set { detailView.onTopRefresh = newValue }
    }

    func setTitle(_ title: String) {
        self.title = title
    }
    
    func display(model: DetailViewModelAdvertisement) {
        detailView.display(model: model)
    }
    
    func endRefreshing() {
        detailView.endRefreshing()
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
        detailView.frame = view.bounds
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

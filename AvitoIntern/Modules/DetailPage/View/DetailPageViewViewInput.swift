@MainActor protocol DetailPageViewViewInput: MutableViewLifecycleObserver {
    
    var onTopRefresh: (() -> ())? { get set }

    func setTitle(_ title: String)
    func display(model: DetailViewModelAdvertisement)
    func endRefreshing()
}


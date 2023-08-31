@MainActor protocol MainViewViewInput: MutableViewLifecycleObserver {
    
    var onTopRefresh: (() -> ())? { get set }
    var onCellTap: ((_ id: String) -> ())? { get set }

    func setTitle(_ title: String)
    func display(models: [CollectionViewModel])
    func endRefreshing()
}

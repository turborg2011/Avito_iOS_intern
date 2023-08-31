import UIKit

final class CollectionView: UIView, UICollectionViewDataSource {
    
    // MARK: - Callbacks
    var onTopRefresh: (() -> ())?
    var onCellTap: ((_ id: String) -> ())?
    
    // MARK: - Data
    private var models: [CollectionViewModel] = []
    private var registerIds: Set<String> = []
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 6.0
        let insetRight: CGFloat = 6.0
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: insetLeft,
                                           bottom: 5.0,
                                           right: insetRight)
        let itemWidth = UIScreen.main.bounds.width / 2 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemWidth, height: 300.0)
        return layout
      }()
    
    // MARK: - Subviews
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: self.frame, collectionViewLayout: layout)
    }()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUpContent() {
        
        collectionView.backgroundColor = Spec.backgroundColor
        
        refreshControl.addTarget(self, action: #selector(onTopRefresh(_:)), for: .valueChanged)
    }
    
    // MARK: - Methods
    func display(models: [CollectionViewModel]) {
        guard self.models != models else { return }
        
        self.models = models
        collectionView.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item < models.count else { return UICollectionViewCell() }
        
        let model = models[indexPath.item]
        let cell = cell(indexPath: indexPath, model: model)

        if let cell = cell as? CollectionViewCellInput {
            cell.update(with: model.data)
        }
        
        return cell
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.safeAreaLayoutGuide.layoutFrame
        collectionView.layer.cornerRadius = Spec.cornerRadius
    }
    
    // MARK: - Private methods
    func cell(indexPath: IndexPath, model: CollectionViewModel) -> UICollectionViewCell {
        collectionView.register(
            model.cellType,
            forCellWithReuseIdentifier: "\(model.self)"
        )
        
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: "\(model.self)",
            for: indexPath
        )
    }
    
    @objc private func onTopRefresh(_ sender: UIRefreshControl) {
        onTopRefresh?()
    }
    
}

extension CollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = models[indexPath.item].id
        onCellTap?(id)
    }
}

fileprivate enum Spec {
    static let backgroundColor = UIColor.white
    static let cornerRadius: CGFloat = 30
}

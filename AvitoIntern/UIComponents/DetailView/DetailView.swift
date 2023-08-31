import UIKit

final class DetailView: UIView {
    
    // MARK: - Callbacks
    var onTopRefresh: (() -> ())?
    
    // MARK: - Subviews
    //private let refreshControl = UIRefreshControl()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        print("UI VIEW IS CREATED")
        
        //addSubview(refreshControl)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUpContent() {
        self.backgroundColor = .gray
        
        //refreshControl.addTarget(self, action: #selector(onTopRefresh(_:)), for: .valueChanged)
    }
    
    // MARK: - Methods
    func display(model: DetailViewModelAdvertisement) {
        
        titleLabel.text = model.title
        priceLabel.text = model.price
        imageView.image = model.image
    }
    
    func endRefreshing() {
        //refreshControl.endRefreshing()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = superview?.safeAreaLayoutGuide.layoutFrame ?? .zero
        
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Private methods
    @objc private func onTopRefresh(_ sender: UIRefreshControl) {
        //onTopRefresh?()
    }
}

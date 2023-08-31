import UIKit

final class AdvertismentCell: UICollectionViewCell, CollectionViewCellInput {
    
    // MARK: - Subviews
    private let title = UILabel()
    private let price = UILabel()
    private let locationLabel = UILabel()
    private let createdDateLabel = UILabel()
    private let adImage = UIImageView()
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TableViewCellInput
    func update(with data: Any) {
        guard let data = data as? AdvertismentCellData else { return }
        
        title.text = "\(data.title)"
        price.text = "Price: \(data.price)"
        locationLabel.text = "\(data.location)"
        createdDateLabel.text = "\(data.created_date)"
        
        adImage.image = data.image
    }
    
    // MARK: - SetupUI
    func setupUI() {
        self.backgroundColor = .black
        self.layer.cornerRadius = Spec.cornerRadius
        
        let backGroundInfoView = UIView()
        
        self.addSubview(backGroundInfoView)
        
        backGroundInfoView.addSubview(title)
        backGroundInfoView.addSubview(price)
        backGroundInfoView.addSubview(locationLabel)
        backGroundInfoView.addSubview(createdDateLabel)
        backGroundInfoView.addSubview(adImage)
        
        backGroundInfoView.backgroundColor = .systemBackground
        backGroundInfoView.layer.cornerRadius = Spec.imageCornerRadius
        
        backGroundInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        adImage.translatesAutoresizingMaskIntoConstraints = false
        adImage.contentMode = .scaleAspectFill
        adImage.clipsToBounds = true
        adImage.layer.cornerRadius = Spec.imageCornerRadius
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.font = Spec.titleFont
        
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textAlignment = .right
        price.font = Spec.priceFont
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .right
        locationLabel.font = Spec.locationFont
        
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createdDateLabel.textAlignment = .right
        createdDateLabel.font = Spec.createDateFont
        
        NSLayoutConstraint.activate([
            adImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            adImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            adImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            adImage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: Spec.imageBottomInset),
            
            backGroundInfoView.topAnchor.constraint(equalTo: adImage.bottomAnchor, constant: Spec.regularInset),
            backGroundInfoView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            backGroundInfoView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            backGroundInfoView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: backGroundInfoView.topAnchor, constant: Spec.regularInset),
            title.leadingAnchor.constraint(equalTo: backGroundInfoView.leadingAnchor, constant: Spec.regularInset),
            title.trailingAnchor.constraint(equalTo: backGroundInfoView.trailingAnchor, constant: -Spec.regularInset),
            
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Spec.regularInset),
            price.leadingAnchor.constraint(equalTo: backGroundInfoView.leadingAnchor, constant: Spec.regularInset),
            price.trailingAnchor.constraint(equalTo: backGroundInfoView.trailingAnchor, constant: -Spec.regularInset),
            
            locationLabel.topAnchor.constraint(equalTo: price.bottomAnchor, constant: Spec.regularInset),
            locationLabel.leadingAnchor.constraint(equalTo: backGroundInfoView.leadingAnchor, constant: Spec.regularInset),
            locationLabel.trailingAnchor.constraint(equalTo: backGroundInfoView.trailingAnchor, constant: -Spec.regularInset),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Spec.regularInset),
            createdDateLabel.leadingAnchor.constraint(equalTo: backGroundInfoView.leadingAnchor, constant: Spec.regularInset),
            createdDateLabel.trailingAnchor.constraint(equalTo: backGroundInfoView.trailingAnchor, constant: -Spec.regularInset),
            createdDateLabel.bottomAnchor.constraint(equalTo: backGroundInfoView.bottomAnchor, constant: -Spec.regularInset)
            
        ])
    }
    
}

// MARK: - Spec
fileprivate enum Spec {
    static let cornerRadius: CGFloat = 10
    static let imageCornerRadius: CGFloat = 7
    
    static let imageBottomInset: CGFloat = -100
    static let regularInset: CGFloat = 5
    
    static let titleFont = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    static let priceFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    static let locationFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    static let createDateFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    
}

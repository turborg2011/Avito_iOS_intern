import UIKit

final class AdvertismentCell: UICollectionViewCell, CollectionViewCellInput {
    
    // MARK: - Subviews
    private let title = UILabel()
    private let price = UILabel()
    
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
    }
    
    // MARK: - SetupUI
    func setupUI() {
        self.backgroundColor = .darkGray
        
        contentView.addSubview(title)
        contentView.addSubview(price)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .right
        
        title.backgroundColor = .blue
        
        price.backgroundColor = .cyan
        
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textAlignment = .right
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            price.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            price.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
        ])
    }
    
}

// MARK: - Spec
fileprivate enum Spec { }

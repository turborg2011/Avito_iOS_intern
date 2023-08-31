import UIKit

final class DetailView: UIView {
    
    // MARK: - Callbacks
    var onTopRefresh: (() -> ())?
    
    // MARK: - Subviews
    //private let refreshControl = UIRefreshControl()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let imageView = UIImageView()
    private let location = UILabel()
    private let createdDate = UILabel()
    private let descriptionView = UITextView()
    private let email = UILabel()
    private let phoneNumber = UILabel()
    private let address = UILabel()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUpContent() {
        self.backgroundColor = .white
        
        //refreshControl.addTarget(self, action: #selector(onTopRefresh(_:)), for: .valueChanged)
    }
    
    // MARK: - Methods
    func display(model: DetailViewModelAdvertisement) {
        
        titleLabel.text = "\(model.title)"
        priceLabel.text = "Цена: \(model.price)"
        imageView.image = model.image
        location.text = "Регион: \(model.location)"
        createdDate.text = "Дата созд.: \(model.created_date)"
        descriptionView.text = "\(model.description)"
        email.text = "email: \(model.email)"
        phoneNumber.text = "Тел.: \(model.phone_number)"
        address.text = "Адрес: \(model.address)"
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = superview?.safeAreaLayoutGuide.layoutFrame ?? .zero
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Spec.imageCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let infoViews = [
            titleLabel,
            priceLabel,
            imageView,
            location,
            createdDate,
            descriptionView,
            email,
            phoneNumber,
            address
        ]
        
        for view in infoViews {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        descriptionView.isEditable = false
        descriptionView.backgroundColor = .systemGray6
        descriptionView.layer.cornerRadius = Spec.imageCornerRadius
        
        titleLabel.font = Spec.titleFont
        priceLabel.font = Spec.priceFont
        location.font = Spec.regularFont
        createdDate.font = Spec.createDateFont
        descriptionView.font = Spec.regularFont
        email.font = Spec.regularFont
        phoneNumber.font = Spec.regularFont
        address.font = Spec.regularFont
        
        // Здесь переделать в UIStackView:
        // на него constraint не ставятся почему-то и утечка памяти
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Spec.imageTopOfset),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: Spec.imageBottomInset),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Spec.titleOfset),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            priceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            
            location.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            location.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            location.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            
            createdDate.topAnchor.constraint(equalTo: location.bottomAnchor),
            createdDate.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            createdDate.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            
            descriptionView.topAnchor.constraint(equalTo: createdDate.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            descriptionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            descriptionView.heightAnchor.constraint(equalToConstant: Spec.descHeight),
            
            email.topAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            email.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            email.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            
            phoneNumber.topAnchor.constraint(equalTo: email.bottomAnchor),
            phoneNumber.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            phoneNumber.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),
            
            address.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor),
            address.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spec.regularOfset),
            address.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spec.regularInset),

        ])
    }
}

// MARK: - Spec
fileprivate enum Spec {
    static let imageCornerRadius: CGFloat = 15
    
    static let titleOfset: CGFloat = 10
    static let regularOfset: CGFloat = 10
    static let regularInset: CGFloat = -10
    static let imageTopOfset: CGFloat = 15
    static let imageBottomInset: CGFloat = -400
    
    static let descHeight: CGFloat = 70
    
    static let titleFont = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    static let priceFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    static let locationFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    static let createDateFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    static let regularFont = UIFont.systemFont(ofSize: 16.0, weight: .regular)
}

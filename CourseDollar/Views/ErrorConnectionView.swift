import UIKit



protocol ErrorConnectionViewDelegate: AnyObject {
    func errorConnectionView(didTapReload: ErrorConnectionView) -> Void
}


class ErrorConnectionView: UIView {
    // MARK: - Delegate
    public var delegate: ErrorConnectionViewDelegate?
    
    // MARK: - Views
    
    lazy var wrapperStack: UIStackView = {
        let wrapperStack = UIStackView()
        wrapperStack.translatesAutoresizingMaskIntoConstraints = false
        wrapperStack.axis = .vertical
        wrapperStack.distribution = .equalCentering
        wrapperStack.alignment = .center
        wrapperStack.spacing = 30
        wrapperStack.addArrangedSubview(imageView)
        wrapperStack.addArrangedSubview(reloadButton)
        return wrapperStack
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wifi.exclamationmark")
        imageView.tintColor = .gray
        imageView.alpha = 0.5
        return imageView
    }()
    
    lazy var reloadButton: UIButton = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapReload))
        let reloadButton = UIButton()
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.setTitle("Refresh", for: .normal)
        reloadButton.clipsToBounds = true
        reloadButton.layer.cornerRadius = 10
        reloadButton.backgroundColor = .blue
        reloadButton.addGestureRecognizer(tap)
        return reloadButton
    }()
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(wrapperStack)

        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    
    @objc func didTapReload() {
        delegate?.errorConnectionView(didTapReload: self)
    }
    
    // MARK: - Methods
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            /// Wrapper Stack
            wrapperStack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: wrapperStack.trailingAnchor, constant: 16),
            bottomAnchor.constraint(greaterThanOrEqualTo: wrapperStack.bottomAnchor, constant: 20),
            wrapperStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wrapperStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            /// Image View
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            /// Reload Button
            wrapperStack.trailingAnchor.constraint(equalTo: reloadButton.trailingAnchor, constant: 16),
            reloadButton.leadingAnchor.constraint(equalTo: wrapperStack.leadingAnchor, constant: 16),
            reloadButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

import UIKit


class NotificationCell: UITableViewCell {
    // MARK: - Item
    
    public var item: Notification?
    // MARK: - View
    
    lazy var wrapperStack: UIStackView = {
        let wrapperStack = UIStackView()
        wrapperStack.translatesAutoresizingMaskIntoConstraints = false
        wrapperStack.distribution = .equalCentering
        wrapperStack.alignment = .top
        wrapperStack.spacing = 10
        wrapperStack.addArrangedSubview(badgeView)
        wrapperStack.addArrangedSubview(infoLabel)
        wrapperStack.addArrangedSubview(dateLabel)
        return wrapperStack
    }()
    
    lazy var badgeView: UIView = {
        let badgeLabel = UIView()
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.backgroundColor = .red
        badgeLabel.clipsToBounds = false
        badgeLabel.layer.cornerRadius = 5
        return badgeLabel
    }()
    
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = UIFont(name: "Arial", size: 10)
        infoLabel.text = "old -> new"
        infoLabel.textColor = .label
        infoLabel.numberOfLines = 0
        return infoLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Arial", size: 14)
        dateLabel.text = "12.03.2020"
        dateLabel.textColor = .label
        dateLabel.alpha = 0.5
        return dateLabel
    }()
    
    lazy var detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.font = UIFont(name: "Arial", size: 10)
        detailsLabel.text = "Update course USD"
        detailsLabel.textColor = .label
        detailsLabel.alpha = 0.5
        return detailsLabel
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(wrapperStack)
        addSubview(detailsLabel)
        
        setupItem()
        setupConstraints()
    }
    
    private func setupItem() {
        guard let item = item else { return }
        
        badgeView.isHidden = item.looked
        infoLabel.text = "\(item.oldCourse ?? "") -> \(item.newCourse ?? "")"
        dateLabel.text = DateUtils.getDateFormat(date: item.dateUpdate ?? Date())
                
        backgroundColor = item.looked
            ? UIColor.white
            : UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            /// Courese Label
            wrapperStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: wrapperStack.trailingAnchor, constant: 16),
            wrapperStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            /// Badge View
            badgeView.heightAnchor.constraint(equalToConstant: 10),
            badgeView.widthAnchor.constraint(equalToConstant: 10),
            /// Details Label
            detailsLabel.topAnchor.constraint(equalTo: wrapperStack.bottomAnchor, constant: 5),
            trailingAnchor.constraint(equalTo: detailsLabel.trailingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 10),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
}

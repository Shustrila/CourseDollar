import UIKit


class CoureseDollarCell: UITableViewCell {
    // MARK: - Item
    
    public var item: CourseDollar?
    // MARK: - View
    
    lazy var coureseLabel: UILabel = {
        let coureseLabel = UILabel()
        coureseLabel.translatesAutoresizingMaskIntoConstraints = false
        coureseLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        coureseLabel.font = UIFont(name: "Arial", size: 18)
        coureseLabel.textColor = .label
        coureseLabel.numberOfLines = 0
        return coureseLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.font = UIFont(name: "Arial", size: 18)
        dateLabel.textColor = .label
        dateLabel.alpha = 0.5
        return dateLabel
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        coureseLabel.text = item?.course
        dateLabel.text = item?.date
        
        addSubview(coureseLabel)
        addSubview(dateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            /// Courese Label
            coureseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: coureseLabel.trailingAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: coureseLabel.bottomAnchor, constant: 10),
            coureseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            /// Date Label
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
        ])
    }
}

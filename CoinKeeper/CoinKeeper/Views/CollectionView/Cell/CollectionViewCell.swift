
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var reiseId = "CollectionViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Market"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 150"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGreen
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update
    func update(_ transaction: Transaction) {
           titleLabel.text = transaction.title
           amountLabel.text = String(format: "$%.2f", transaction.amount)
       }
}



extension CollectionViewCell {
    
    func setup() {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        backgroundColor = .white
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(amountLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).inset(20)
            make.centerY.equalTo(contentView)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(20)
            make.centerY.equalTo(contentView)
        }
    }
}

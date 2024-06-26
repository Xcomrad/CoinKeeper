
import UIKit

class MainView: UIView {
    
    let dataManager = Di.shared.dataManager
    
    var completionPresentDeleteAlert: ((UIAlertController)->())?
    var updateTotalCount: (()->())?
    
    lazy var totalLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reiseId, for: indexPath) as! CollectionViewCell
        
        let transaction = dataManager.transactions[indexPath.row]
        cell.update(transaction)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transaction = dataManager.transactions[indexPath.row]
        let alert = UIAlertController(title: "Удалить транзакицю", message: "Вы уверенны, что хотите удалить \(transaction.title)?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            self.dataManager.transactions.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            self.dataManager.saveTransactions()
            self.updateTotalCount?()
        }))
        self.completionPresentDeleteAlert?(alert)
    }
}



extension MainView {
    
    func setupView() {
        backgroundColor = .systemGray6
        addSubview(collectionView)
        addSubview(totalLabel)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(totalLabel.snp.bottom).inset(50)
            make.leading.trailing.equalTo(self)
        }
        totalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(self)
        }
    }
}

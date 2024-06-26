
import UIKit
import SnapKit

final class MainController: UIViewController {
    
    private let dataManager = DataManagerImpl()
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        dataManager.getTransactions()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavItems()
    }
    
    func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavItems() {
        title = "Mой кошелек"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, 
                                        target: self, action: #selector(addNewTransaction))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addNewTransaction() {
        let addVC = AmountController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
}



extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        }))
        present(alert, animated: true, completion: nil)
    }
}



extension MainController: AddTransactionDelegate {
    func didAddTransaction(_ transaction: Transaction) {
        dataManager.transactions.append(transaction)
        collectionView.reloadData()
        dataManager.saveTransactions()
    }
}


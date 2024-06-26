
import UIKit
import SnapKit

final class MainController: UIViewController {
    
    private let dataManager = Di.shared.dataManager
    private let rootView = MainView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        rootView.dataManager.getTransactions()
        totalCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.updateTotalCount = {
            self.totalCount()
        }
        
        showDeleteAlert()
        setupNavItems()
    }
    
    func showDeleteAlert() {
        rootView.completionPresentDeleteAlert = { alert in
            self.present(alert, animated: true)
        }
    }
    
    func totalCount() {
        let totalCount = dataManager.transactions.reduce(0) { $0 + $1.amount }
        rootView.totalLabel.text = String(format: "Всего: $%.2f", totalCount)
        rootView.totalLabel.textColor = totalCount < 0 ? .red : .systemGreen
    }
    
    //MARK: Action
    @objc func addNewTransaction() {
        let addVC = AmountController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
}



extension MainController: AddTransactionDelegate {
    func didAddTransaction(_ transaction: Transaction) {
        dataManager.transactions.append(transaction)
        rootView.collectionView.reloadData()
        dataManager.saveTransactions()
        totalCount()
    }
}



extension MainController {
    
    func setupNavItems() {
        title = "Mой кошелёк"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self, 
                                        action: #selector(addNewTransaction))
        navigationItem.rightBarButtonItem = addButton
    }
}

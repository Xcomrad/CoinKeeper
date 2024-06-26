
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDeleteAlert()
        setupNavItems()
    }
    
    func showDeleteAlert() {
        rootView.completionPresentDeleteAlert = { alert in
            self.present(alert, animated: true)
        }
    }
    
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
    }
}



extension MainController {
    
    func setupNavItems() {
        title = "Mой кошелек"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self, action: #selector(addNewTransaction))
        navigationItem.rightBarButtonItem = addButton
    }
}

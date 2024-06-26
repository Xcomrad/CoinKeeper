
import UIKit

protocol AddTransactionDelegate: AnyObject {
    func didAddTransaction(_ transaction: Transaction)
}

final class AmountController: UIViewController {
    
    weak var delegate: AddTransactionDelegate?
    private let rootView = AmountView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewTransaction()
        getAlert()
        
        setupNavItems()
    }
    
    func getNewTransaction() {
        rootView.completionAddTransaction = { newTransaction in
            self.delegate?.didAddTransaction(newTransaction)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getAlert() {
        rootView.completionPresentAlert = { alert in
            self.present(alert, animated: true)
        }
    }
}



extension AmountController {
    
    func setupNavItems() {
        title = "Добавить"
    }
}


import UIKit
import SnapKit

final class MainController: UIViewController {
    
    private let rootView = MainView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        
        title = "Твой кошелёк"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, 
                                        action: #selector(addNewTransaction))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addNewTransaction() {
        
    }
}


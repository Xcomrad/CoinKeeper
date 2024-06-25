
import UIKit

class MainControlelr: UIViewController {
    
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
    }
}


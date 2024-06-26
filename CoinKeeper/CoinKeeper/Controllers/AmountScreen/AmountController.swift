
import UIKit

protocol AddTransactionDelegate: AnyObject {
    func didAddTransaction(_ transaction: Transaction)
}

class AmountController: UIViewController {
    
    weak var delegate: AddTransactionDelegate?
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Категория"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сумма"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.systemGreen, for: .highlighted)
        button.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupConstraints()
        setupNavItems()
    }
    
    @objc func addTransaction() {
        guard let title = titleTextField.text, !title.isEmpty,
              let amountText = amountTextField.text, !amountText.isEmpty,
              let amount = Double(amountText) else {
            let alert = UIAlertController(title: "Упс", message: "Пожалуйста, заполните все поля", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let newTransaction = Transaction(id: UUID(), title: title, amount: amount)
        delegate?.didAddTransaction(newTransaction)
        navigationController?.popViewController(animated: true)
    }
}



extension AmountController {
    
    func setup() {
        view.backgroundColor = .systemGray6
    }
    
    func setupViews() {
        view.addSubview(titleTextField)
        view.addSubview(amountTextField)
        view.addSubview(addButton)
    }
    
    func setupConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.bottom.equalTo(titleTextField.snp.bottom).offset(50)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.top).inset(70)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(view).inset(20)
        }
    }
    
    func setupNavItems() {
        title = "Добавить"
    }
}

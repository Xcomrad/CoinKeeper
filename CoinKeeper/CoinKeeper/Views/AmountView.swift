
import UIKit

class AmountView: UIView {
    
    var completionAddTransaction: ((Transaction)->())?
    var completionPresentAlert: ((UIAlertController)->())?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc func addTransaction() {
        guard let title = titleTextField.text, !title.isEmpty,
              let amountText = amountTextField.text, !amountText.isEmpty,
              let amount = Double(amountText) else {
            let alert = UIAlertController(title: "Упс", message: "Пожалуйста, заполните все поля", preferredStyle: .actionSheet)
            alert.addAction(.init(title: "Oк", style: .default))
            self.completionPresentAlert?(alert)
            return
        }
        let newTransaction = Transaction(id: UUID(), title: title, amount: amount)
        self.completionAddTransaction?(newTransaction)
    }
}



extension AmountView {
    
    func setup() {
        backgroundColor = .systemGray6
    }
    
    func setupViews() {
        addSubview(titleTextField)
        addSubview(amountTextField)
        addSubview(addButton)
    }
    
    func setupConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.bottom.equalTo(titleTextField.snp.bottom).offset(50)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.top).inset(70)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
}

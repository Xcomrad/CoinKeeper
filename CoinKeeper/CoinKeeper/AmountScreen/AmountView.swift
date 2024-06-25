
import UIKit

class AmountView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .systemGray6
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
}

//
//  BaseTextField.swift
//  AraBook
//
//  Created by 고아라 on 10/9/24.
//

import UIKit

class BaseTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }
    
    convenience init(isSecureEntry: Bool = false,
                     keyboardType: UIKeyboardType,
                     returnKeyType: UIReturnKeyType = .done) {
        self.init(frame: .zero)
        
        self.isSecureTextEntry = isSecureEntry
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = .none
    }
    
    func configure() {}
    func bind() {}
}

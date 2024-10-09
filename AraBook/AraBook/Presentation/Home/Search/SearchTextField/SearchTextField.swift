//
//  SearchTextField.swift
//  AraBook
//
//  Created by 고아라 on 10/9/24.
//

import UIKit

class SearchTextField: BaseTextField {
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(.icSearch, for: .normal)
        return button
    }()
    
    override func configure() {
        super.configure()
        
        delegate = self
        borderStyle = .none
        textColor = .label
        font = .araFont(type: .PretandardRegular, size: 14)
        attributedPlaceholder = NSAttributedString(string: "도서명을 입력해주세요",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText])
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.gray500.cgColor
        layer.cornerRadius = 10.0
        
        clearButtonMode = .never
        
        leftView = searchButton
        leftViewMode = .always
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.leftViewRect(forBounds: bounds)
        padding.origin.x += 12
        return padding
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 14.0, left: 38.0, bottom: 14.0, right: 0.0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 14.0, left: 38.0, bottom: 14.0, right: 36.0))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 16.0, left: 38.0, bottom: 14.0, right: 36.0))
    }
    
}

extension SearchTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        layer.borderColor = newText.isEmpty ? UIColor.gray800.cgColor : UIColor.mainGreen.cgColor
        searchButton.setImage(newText.isEmpty ? .icSearch : .icSearchGreen, for: .normal)
        return true
    }
}

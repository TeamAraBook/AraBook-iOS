//
//  CheckButton.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import UIKit

enum CheckButtonState {
    case allow
    case notAllow
}

final class CheckButton: UIButton {
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    func setUI() {
        layer.cornerRadius = 16
        titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
        setTitleColor(.white, for: .normal)
        setState(.notAllow)
    }
    
    // MARK: - Methods
    
    public func setState(_ state: CheckButtonState) {
        if state == .allow {
            backgroundColor = .mainGreen
            isUserInteractionEnabled = true
        } else {
            backgroundColor = .gray200
            isUserInteractionEnabled = false
        }
    }
}

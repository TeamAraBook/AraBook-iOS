//
//  UIStackView+.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

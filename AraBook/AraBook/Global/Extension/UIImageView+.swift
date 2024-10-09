//
//  UIImageView+.swift
//  AraBook
//
//  Created by KJ on 10/9/24.
//

import UIKit

extension UIImageView {
    
    /// Adds a blur effect to the UIImageView
    /// - Parameters:
    ///   - style: UIBlurEffect.Style, default is .light
    func addBlurEffect(style: UIBlurEffect.Style) {
        // Check if the blur effect is already added
        if !subviews.contains(where: { $0 is UIVisualEffectView }) {
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(blurEffectView)
        }
    }
    
    /// Removes the blur effect from the UIImageView
    func removeBlurEffect() {
        // Remove any UIVisualEffectView subviews
        subviews.filter { $0 is UIVisualEffectView }.forEach { $0.removeFromSuperview() }
    }
}

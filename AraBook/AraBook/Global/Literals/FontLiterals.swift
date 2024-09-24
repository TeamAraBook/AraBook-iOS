//
//  FontLiterals.swift
//  AraBook
//
//  Created by 고아라 on 9/24/24.
//

import UIKit

enum FontType: String {
    case PretandardBold = "Pretendard-Bold"
    case PretandardRegular = "Pretendard-Regular"
    case PretandardSemiBold = "Pretendard-SemiBold"
    
    case PyeongChangBold = "PyeongChang-Bold"
}

extension UIFont {
    
    static func araFont(type: FontType, size: CGFloat) -> UIFont {
        let baseFont = UIFont(name: type.rawValue, size: size)!
        return baseFont
    }
}

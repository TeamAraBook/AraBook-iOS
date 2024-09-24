//
//  TabBarItem.swift
//  AraBook
//
//  Created by 고아라 on 9/24/24.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case record
    case myPage
}

extension TabBarItemType {
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return .icHomeUnselected
        case .record:
            return .icRecordUnselected
        case .myPage:
            return .icMypageUnselected
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return .icHomeSelected
        case .record:
            return .icRecordSelected
        case .myPage:
            return .icMypageSelected
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "", image: unSelectedIcon, selectedImage: selectedIcon)
    }
}

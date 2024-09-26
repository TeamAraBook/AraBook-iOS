//
//  TabBarController.swift
//  AraBook
//
//  Created by 고아라 on 9/24/24.
//

import Foundation

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let tabBarHeight: CGFloat = 84
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        setTabBarUI()
        setTabBarHeight()
    }
    
}

private extension TabBarController {
    
    func setTabBarItems() {
        let homeVC = UINavigationController(rootViewController: ViewController())
        let recordVC = UINavigationController(rootViewController: ViewController())
        let mypageVC = UINavigationController(rootViewController: ViewController())
        
        let tabs = [
            homeVC,
            recordVC,
            mypageVC
        ]
        
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
            tabs[$0.rawValue].tabBarItem = tabBarItem
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        let tabBarItemTitles: [String] = ["홈",
                                          "내 기록",
                                          "MY"]
        
        for (index, tabTitle) in tabBarItemTitles.enumerated() {
            let tabBarItem = TabBarItemType(rawValue: index)?.setTabBarItem()
            tabs[index].tabBarItem = tabBarItem
            tabs[index].tabBarItem.tag = index
            tabs[index].title = tabTitle
        }
        
        setViewControllers(tabs, animated: false)
        selectedViewController = tabs[1]
    }
    
    func setTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .mainGreen
        tabBar.unselectedItemTintColor = .gray300
    }
    
    func getSafeAreaBottomHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets
            let bottomSafeAreaHeight = safeAreaInsets?.bottom ?? 0
            return bottomSafeAreaHeight
        }
        return 0
    }
    
    func setTabBarHeight() {
        if let tabBar = self.tabBarController?.tabBar {
            let safeAreaBottomInset = self.view.safeAreaInsets.bottom
            let tabBarHeight = tabBar.bounds.height
            let newTabBarFrame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y, width: tabBar.frame.width, height: tabBarHeight + safeAreaBottomInset)
            tabBar.frame = newTabBarFrame
        }
    }
}

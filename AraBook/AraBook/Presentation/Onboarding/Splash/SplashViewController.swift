//
//  SplashViewController.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import UIKit

import SnapKit

final class SplashViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let backImageView = UIImageView(image: UIImage(resource: .imgBackground))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.checkToken()
        }
    }
}

extension SplashViewController {
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    func setHierarchy() {
        view.addSubview(backImageView)
    }
    
    func setLayout() {
        backImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func checkToken() {
        if UserManager.shared.hasAccessToken {
            let nav = TabBarController()
            self.navigationController?.pushViewController(nav, animated: true)
        } else {
            let nav = LoginViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}

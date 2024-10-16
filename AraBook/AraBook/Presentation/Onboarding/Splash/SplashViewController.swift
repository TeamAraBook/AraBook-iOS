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
    private let logoImageView = UIImageView(image: .imgLogo)
    
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
        view.addSubviews(backImageView, logoImageView)
    }
    
    func setLayout() {
        backImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(300)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(180)
        }
    }
    
    func checkToken() {
        if UserManager.shared.hasAccessToken {
            if UserManager.shared.doOnboarding ?? false {
                let nav = TabBarController()
                self.navigationController?.pushViewController(nav, animated: true)
            } else {
                let nav = FirstOnboardingViewController()
                self.navigationController?.pushViewController(nav, animated: true)
            }
        } else {
            let nav = LoginViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}

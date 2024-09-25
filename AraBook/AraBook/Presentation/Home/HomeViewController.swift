//
//  HomeViewController.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import UIKit

import SnapKit

final class HomeViewController: UIViewController {
    
    private let todayBookView = HomeTodayBookView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
    }
}

extension HomeViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setHierarchy() {
        view.addSubview(todayBookView)
    }
    
    func setLayout() {
        todayBookView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(390)
        }
    }
}

//
//  SerachViewController.swift
//  AraBook
//
//  Created by 고아라 on 10/8/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class SerachViewController: UIViewController {
    
    // MARK: - Properties
    
//    private let homeVM = HomeViewModel()
//    private let viewWillAppear = PublishRelay<Void>()
//    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let navi = CustomNavigationBar()
        navi.isTitleLabelIncluded = "검색하기"
        navi.isTitleViewIncluded = true
        navi.isBackButtonIncluded = true
        return navi
    }()
    
    private let searchTextField = SearchTextField()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.viewWillAppear.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
    }
}

extension SerachViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar,
                         searchTextField)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

//
//  BookDetailViewController.swift
//  AraBook
//
//  Created by KJ on 10/2/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class BookDetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar()
    
    // MARK: - Properties
    
    private let bookDetailVM = BookDetailViewModel()
    private let viewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewWillAppear.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
    }
}

extension BookDetailViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
            $0.isTitleLabelIncluded = "도서상세"
            $0.isTitleViewIncluded = true
        }
    }
    
    func bindViewModel() {
        let input = BookDetailViewModel.Input(
            viewWillAppear: viewWillAppear
        )
        
        let output = bookDetailVM.transform(input: input)
    
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar)
    }
    
    func setLayout() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }

    }
}

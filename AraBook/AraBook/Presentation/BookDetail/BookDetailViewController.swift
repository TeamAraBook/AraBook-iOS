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

    private let bookDetailView = BookDetailView()
    private let scrollView = UIScrollView()
    
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
    }
    
    func bindViewModel() {
        let input = BookDetailViewModel.Input(
            viewWillAppear: viewWillAppear
        )
        
        let output = bookDetailVM.transform(input: input)
    
    }
    
    func setHierarchy() {
        scrollView.addSubviews(bookDetailView)
        view.addSubviews(scrollView)
    }
    
    func setLayout() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bookDetailView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
    }
}

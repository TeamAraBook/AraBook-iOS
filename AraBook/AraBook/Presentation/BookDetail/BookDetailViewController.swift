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
    private let disposeBag = DisposeBag()
    private var bookId: Int
    
    // MARK: - Initializer

    init(bookId: Int) {
        self.bookId = bookId
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookDetailViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindViewModel() {
        
        bookDetailVM.inputs.getBookDetail(bookId)
        
        bookDetailVM.outputs.bindBookDetail
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                bookDetailView.bindBookDetail(data)
            })
            .disposed(by: disposeBag)
        
        bookDetailView.writeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                present(RecordBookViewController(bookId: bookId), animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    func setHierarchy() {
        scrollView.addSubviews(bookDetailView)
        view.addSubviews(scrollView)
    }
    
    func setLayout() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        bookDetailView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
    }
}

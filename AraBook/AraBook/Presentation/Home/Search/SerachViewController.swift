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
    
    private let searchVM = SearchViewModel()
    private let viewWillAppear = PublishRelay<Void>()
    private let searchTapped = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let navi = CustomNavigationBar()
        navi.isTitleLabelIncluded = "검색하기"
        navi.isTitleViewIncluded = true
        navi.isBackButtonIncluded = true
        return navi
    }()
    
    private lazy var searchTextField = SearchTextField()
    
    private let searchResultView = SearchResultView()
    
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
        bindSearchTextField()
        bindViewModel()
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
                         searchTextField,
                         searchResultView)
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
        
        searchResultView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bindSearchTextField() {
        searchTextField.rx.text
            .orEmpty
            .subscribe(onNext: { text in
                self.searchTapped.accept(text)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = SearchViewModel.Input(
            viewWillAppear: viewWillAppear,
            searchTapped: searchTapped
        )
        
        let output = searchVM.transform(input: input)
        
        output.bookSearchData
            .bind(to: searchResultView.resultCollectionView.rx
                .items(cellIdentifier: BookCollectionViewCell.className,
                       cellType: BookCollectionViewCell.self)) { (_, dto, cell) in
                cell.bindSearchBook(model: dto)
            }
            .disposed(by: disposeBag)
        
        output.bookSearchCount
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                searchResultView.bindSearchCount(title: searchTextField.text ?? "",
                                                 cnt: data)
            })
            .disposed(by: disposeBag)
    }
}

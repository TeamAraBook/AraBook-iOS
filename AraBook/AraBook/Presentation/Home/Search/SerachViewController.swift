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
    private let showRecent = PublishRelay<Void>()
    private let selectRecent = PublishRelay<Int>()
    private let deleteRecent = PublishRelay<Int>()
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
    private let recentSearchView = RecentSearchView()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showRecent.accept(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        bindSearchTextField()
        bindViewModel()
        bindCollectionView()
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
                         searchResultView,
                         recentSearchView)
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
        
        recentSearchView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
    }
    
    func bindSearchTextField() {
        searchTextField.rx.text
            .orEmpty
            .subscribe(onNext: { text in
                self.recentSearchView.isHidden = !(text.isEmpty)
                self.searchResultView.isHidden = (text.isEmpty)
                if text.isEmpty {
                    self.showRecent.accept(())
                } else {
                    self.searchTapped.accept(text)
                }
            })
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                guard let self = self, let searchText = self.searchTextField.text,
                        !searchText.isEmpty else { return }
                LocalDBService.shared.insertData(word: searchText)
                self.searchTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    func bindCollectionView() {
        recentSearchView.recentCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.selectRecent.accept(indexPath.item)
            })
            .disposed(by: disposeBag)
        
        searchResultView.resultCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if let cell = self.searchResultView.resultCollectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
                    let nav = BookDetailViewController(bookId: cell.searchBookId)
                    nav.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(nav, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = SearchViewModel.Input(
            searchTapped: searchTapped,
            showRecent: showRecent,
            selectRecent: selectRecent,
            deleteRecent: deleteRecent
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
        
        output.recentSearchData
            .bind(to: recentSearchView.recentCollectionView.rx
                .items(cellIdentifier: RecentCollectionViewCell.className,
                       cellType: RecentCollectionViewCell.self)) { (indexpath, dto, cell) in
                cell.bindRecentView(title: dto.word)
                cell.delegate = self
            }
            .disposed(by: disposeBag)
        
        output.selectKeywordData
            .subscribe(onNext: { keyword in
                self.searchTextField.text = keyword
                self.recentSearchView.isHidden = true
                self.searchResultView.isHidden = false
                self.searchTextField.setKeyword()
                self.searchTextField.resignFirstResponder()
                LocalDBService.shared.insertData(word: keyword)
            })
            .disposed(by: disposeBag)
    }
}

extension SerachViewController: RecentCellDelegate {
    
    func tapDeleteButtonDelegate(cell: RecentCollectionViewCell) {
        if let indexPath = recentSearchView.recentCollectionView.indexPath(for: cell) {
            self.deleteRecent.accept(indexPath.item)
        }
    }
}

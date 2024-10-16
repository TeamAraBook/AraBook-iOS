//
//  RecordsListViewController.swift
//  AraBook
//
//  Created by KJ on 9/27/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class RecordListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let recordListVM = RecordListViewModel()
    private let viewWillAppear = PublishRelay<Void>()
    private let selectRecordlist = PublishRelay<Int>()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let recordListView = RecordListView()
    
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
        setRegister()
    }
}

private extension RecordListViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        recordListView.recordListCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                if let cell = recordListView.recordListCollectionView.cellForItem(at: indexPath) as? RecordListCell {
                    selectRecordlist.accept(cell.bookId)
                    let nav = RecordDetailViewController(viewModel: self.recordListVM)
                    nav.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(nav, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = RecordListViewModel.Input(
            viewWillAppear: viewWillAppear,
            selectRecordList: selectRecordlist,
            detailViewWillAppear: PublishRelay()
        )
        
        let output = recordListVM.transform(input: input)
        
        recordListVM.bindBookList
            .map { $0.reviews }
            .bind(to: recordListView.recordListCollectionView.rx
                .items(cellIdentifier: RecordListCell.className, cellType: RecordListCell.self)) { (index, model, cell) in
                    cell.configureCell(model)
                }
                .disposed(by: disposeBag)
        
        recordListVM.bindBookList
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                print(data)
            })
            .disposed(by: disposeBag)
        
    }
    
    func setHierarchy() {
        view.addSubview(recordListView)
    }
    
    func setLayout() {
        
        recordListView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setDelegates() {
        
    }
    
    func setRegister() {
        recordListView.recordListCollectionView.register(RecordListCell.self,
                                                         forCellWithReuseIdentifier: RecordListCell.className)
        
    }
}

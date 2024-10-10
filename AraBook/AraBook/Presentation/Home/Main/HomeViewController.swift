//
//  HomeViewController.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeVM = HomeViewModel()
    private let viewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let scrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.contentInsetAdjustmentBehavior = .never
        return scrollview
    }()
    
    private let contentView = UIView()
    
    private let todayBookView = HomeTodayBookView()
    
    private let searchImageView = UIImageView(image: .imgSearch)
    
    private let bestSellerTitle = {
        let label = UILabel()
        label.text = "이달의 베스트셀러"
        label.textColor = .black
        label.font = .araFont(type: .PretandardBold, size: 16)
        return label
    }()
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 109, height: 231)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 28
        let cv = UICollectionView(frame: .zero, 
                                  collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: BookCollectionViewCell.className
        )
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        cv.isScrollEnabled = false
        return cv
    }()
    
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

extension HomeViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        searchImageView.isUserInteractionEnabled = true
        searchImageView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                let nav = SerachViewController()
                nav.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nav, animated: true)
            }
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            viewWillAppear: viewWillAppear
        )
        
        let output = homeVM.transform(input: input)
        
        output.homeAiData
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                todayBookView.bindTodayBook(model: data)
            })
            .disposed(by: disposeBag)
        
        output.homeBestSellerData
            .bind(to: collectionView.rx
                .items(cellIdentifier: BookCollectionViewCell.className,
                       cellType: BookCollectionViewCell.self)) { (_, dto, cell) in
                cell.bindBestSeller(model: dto)
            }
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(searchImageView,
                                todayBookView,
                                bestSellerTitle,
                                collectionView)
    }
    
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        todayBookView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(390)
        }
        
        searchImageView.snp.makeConstraints {
            $0.top.equalTo(todayBookView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(343)
        }
        
        bestSellerTitle.snp.makeConstraints {
            $0.top.equalTo(searchImageView.snp.bottom).offset(10)
            $0.leading.equalTo(searchImageView.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bestSellerTitle.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1600)
        }
    }
}

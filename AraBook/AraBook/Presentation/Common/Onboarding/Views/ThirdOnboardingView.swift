//
//  ThirdOnboardingView.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import UIKit

import SnapKit
import Then

final class ThirdOnboardingView: UIView {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar()
    private let subCategoryLabel = UILabel()
    
    private let title1 = UILabel()
    
    private let title2 = UILabel()
    lazy var category2 = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    private let title3 = UILabel()
    lazy var category3 = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    private let flowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 6 // 셀 사이
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 85, height: 29)
        return layout
    }()
    
    lazy var categoryCollectionView1 = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 6 // 셀 사이
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: 85, height: 29)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
        return cv
    }()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThirdOnboardingView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .white
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        subCategoryLabel.do {
            $0.text = "선택한 카테고리에서\n좋아하는 주제를 선택해주세요!"
            $0.font = .araFont(type: .PretandardSemiBold, size: 25)
            $0.textColor = .gray800
            $0.numberOfLines = 2
        }
        
//        flowLayout.do {
//            $0.minimumInteritemSpacing = 6 // 셀 사이
//            $0.minimumLineSpacing = 8
//            $0.scrollDirection = .vertical
//            $0.itemSize = CGSize(width: 85, height: 29)
//        }
        
        title1.do {
            $0.text = "📗 소설"
            $0.font = .araFont(type: .PretandardSemiBold, size: 15)
            $0.textColor = .gray800
        }
        
//        categoryCollectionView1.do {
//            $0.collectionViewLayout = flowLayout
//            $0.isScrollEnabled = true
//            $0.backgroundColor = .clear
//            $0.showsHorizontalScrollIndicator = false
//            $0.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
//        }
        
        title2.do {
            $0.text = "📗 소설"
            $0.font = .araFont(type: .PretandardSemiBold, size: 15)
            $0.textColor = .gray800
        }
        
        category2.do {
            $0.collectionViewLayout = flowLayout
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
        
        title3.do {
            $0.text = "📗 소설"
            $0.font = .araFont(type: .PretandardSemiBold, size: 15)
            $0.textColor = .gray800
        }
        
        category3.do {
            $0.collectionViewLayout = flowLayout
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(navigationBar, subCategoryLabel,
                         title1, title2, title3,
                         categoryCollectionView1
                         , category2, category3)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        subCategoryLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(20)
        }
        
        title1.snp.makeConstraints {
            $0.top.equalTo(subCategoryLabel.snp.bottom).offset(30)
            $0.leading.equalTo(subCategoryLabel)
        }
        
        categoryCollectionView1.snp.makeConstraints {
            $0.top.equalTo(title1.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        
        title2.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView1.snp.bottom).offset(25)
            $0.leading.equalTo(subCategoryLabel)
        }
        
        category2.snp.makeConstraints {
            $0.top.equalTo(title2.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        
        title3.snp.makeConstraints {
            $0.top.equalTo(category2.snp.bottom).offset(25)
            $0.leading.equalTo(subCategoryLabel)
        }
        
        category3.snp.makeConstraints {
            $0.top.equalTo(title3.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

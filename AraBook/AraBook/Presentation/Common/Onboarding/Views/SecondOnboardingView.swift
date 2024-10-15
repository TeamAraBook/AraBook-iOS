//
//  SecondOnboardingView.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import UIKit

import SnapKit
import Then

final class SecondOnboardingView: UIView {
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationBar()
    lazy var secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    private let categoryLabel = UILabel()
    
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

extension SecondOnboardingView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        categoryLabel.do {
            $0.text = "즐겨 읽는 카테고리를\n모두 선택해주세요!"
            $0.font = .araFont(type: .PretandardSemiBold, size: 25)
            $0.textColor = .gray800
            $0.numberOfLines = 2
        }
        
        flowLayout.do {
            $0.minimumInteritemSpacing = 12
            $0.minimumLineSpacing = 16 // 각 셀 간의 간격을 설정
            $0.scrollDirection = .vertical // 가로 스크롤 방지
        }
        
        secondCollectionView.do {
            $0.collectionViewLayout = flowLayout
            $0.isScrollEnabled = true // 수직 스크롤만 허용
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(navigationBar, secondCollectionView, categoryLabel)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        secondCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

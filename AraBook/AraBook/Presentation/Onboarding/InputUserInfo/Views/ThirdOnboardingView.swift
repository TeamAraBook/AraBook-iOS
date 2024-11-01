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
    
    let navigationBar = CustomNavigationBar()
    let subCategoryLabel = UILabel()
    var collectionViews: [UICollectionView] = []
    
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
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(navigationBar, subCategoryLabel)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        subCategoryLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}

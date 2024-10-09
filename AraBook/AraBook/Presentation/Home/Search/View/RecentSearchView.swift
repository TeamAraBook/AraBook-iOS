//
//  RecentSearchView.swift
//  AraBook
//
//  Created by 고아라 on 10/8/24.
//

import UIKit

import SnapKit
import Then

final class RecentSearchView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private lazy var recentCollectionView = UICollectionView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension RecentSearchView {
    
    func setUI() {
        titleLabel.do {
            $0.text = "최근 검색어"
            $0.textColor = .black
            $0.font = .araFont(type: .PretandardRegular, size: 12)
        }
        
        recentCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 10
            let cv = UICollectionView(frame: .zero,
                                      collectionViewLayout: layout)
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.register(
                RecentCollectionViewCell.self,
                forCellWithReuseIdentifier: RecentCollectionViewCell.className
            )
        }
    }
    
    func setHierarchy() {
        addSubviews(titleLabel,
                    recentCollectionView)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        recentCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(24)
        }
    }
}

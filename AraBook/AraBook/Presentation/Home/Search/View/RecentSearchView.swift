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
    lazy var recentCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 35)
        layout.minimumInteritemSpacing = 10
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(
            RecentCollectionViewCell.self,
            forCellWithReuseIdentifier: RecentCollectionViewCell.className
        )
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return cv
    }()
    
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
            $0.font = .araFont(type: .PretandardSemiBold, size: 12)
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(35)
        }
    }
}

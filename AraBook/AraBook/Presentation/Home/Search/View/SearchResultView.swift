//
//  SearchResultView.swift
//  AraBook
//
//  Created by 고아라 on 10/8/24.
//

import UIKit

import SnapKit
import Then

final class SearchResultView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    
    lazy var resultCollectionView = {
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
        return cv
    }()
    
    private let emptyImageView = UIImageView(image: .imgEmpty)
    
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

private extension SearchResultView {
    
    func setUI() {
        titleLabel.do {
            $0.textColor = .gray900
            $0.font = .araFont(type: .PretandardRegular, size: 12)
        }
        
        emptyImageView.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(titleLabel,
                    resultCollectionView,
                    emptyImageView)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(146)
        }
    }
}

extension SearchResultView {
    
    func bindSearchCount(title: String, cnt: Int) {
        titleLabel.text = "'\(title)' 검색결과 \(cnt)건"
        emptyImageView.isHidden = (cnt > 0)
    }
}

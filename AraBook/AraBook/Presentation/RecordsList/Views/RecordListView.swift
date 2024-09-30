//
//  RecordListView.swift
//  AraBook
//
//  Created by KJ on 9/27/24.
//

import UIKit

import SnapKit
import Then

final class RecordListView: UIView {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar()
    lazy var recordListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    
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

extension RecordListView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        navigationBar.do {
            $0.isTitleLabelIncluded = "나의 독서 기록"
            $0.isTitleViewIncluded = true
        }
        
        recordListCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        flowLayout.do {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 42, height: 150)
            $0.minimumLineSpacing = 14
            $0.minimumInteritemSpacing = 0
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(navigationBar, recordListCollectionView)
        
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        recordListCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

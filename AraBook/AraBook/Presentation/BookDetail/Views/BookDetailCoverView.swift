//
//  BookDetailCoverView.swift
//  AraBook
//
//  Created by KJ on 10/9/24.
//

import UIKit

import SnapKit
import Then

final class BookDetailCoverView: UIView {
    
    // MARK: - UI Components
    
    let navigationBar = CustomNavigationBar()
    let bookBackgroundImageView = UIImageView(image: .imgBook)
    let bookImageView = UIImageView(image: .imgBook)
    let bookTitleLabel = UILabel()
    let authorLabel = UILabel()
    
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

extension BookDetailCoverView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        navigationBar.do {
            $0.isWhiteBackButtonIncluded = true
            $0.isTitleLabelIncluded = "도서상세"
            $0.isTitleViewIncluded = true
            $0.titleLabel.textColor = .white
            $0.backgroundColor = .clear
        }
        
        bookBackgroundImageView.do {
            $0.addBlurEffect(style: .dark)
        }
        
        bookTitleLabel.do {
            $0.text = "퀸의 대각선"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .araFont(type: .PyeongChangBold, size: 20)
        }
        
        authorLabel.do {
            $0.text = "베르나르베르베르"
            $0.textColor = .white
            $0.font = .araFont(type: .PyeongChangRegular, size: 14)
            $0.textAlignment = .center
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(bookBackgroundImageView)
        bookBackgroundImageView.addSubviews(navigationBar, bookImageView, bookTitleLabel, authorLabel)
        
        bookBackgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(148)
            $0.height.equalTo(245)
            $0.top.equalToSuperview().inset(115)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(bookImageView.snp.bottom).offset(16)
        }
        
        authorLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(4)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

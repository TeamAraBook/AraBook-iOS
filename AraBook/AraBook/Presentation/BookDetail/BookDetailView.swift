//
//  BookDetailView.swift
//  AraBook
//
//  Created by KJ on 10/9/24.
//

import UIKit

import SnapKit
import Then

final class BookDetailView: UIView {
    
    // MARK: - UI Components
    
    private let bookCoverView = BookDetailCoverView()
    private let bookDescriptionView = BookDetailDescriptionView()
    private let writeButton = UIButton()
    
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

extension BookDetailView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        writeButton.do {
            $0.setTitle("기록하기", for: .normal)
            $0.titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .chGreen
            $0.makeCornerRound(radius: 16)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(bookCoverView, bookDescriptionView, writeButton)
        
        bookCoverView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-60)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(450)
        }
        
        bookDescriptionView.snp.makeConstraints {
            $0.top.equalTo(bookCoverView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(writeButton.snp.top)
        }
        
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

//
//  BookReviewView.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import Then

final class BookReviewView: UIView {
    
    // MARK: - UI Components
    
    private let memoLabel = UILabel()
    private let reviewTextView = UITextView()
    
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

extension BookReviewView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .white
        
        memoLabel.do {
            $0.text = "메모"
            $0.font = .araFont(type: .PretandardRegular, size: 14)
            $0.textColor = .black
        }
        
        reviewTextView.do {
            $0.text = "책에 대한 간단한 소감을 적어주세요."
            $0.font = .araFont(type: .PretandardRegular, size: 14)
            $0.textColor = .gray500
            $0.backgroundColor = .gray200
            $0.makeCornerRound(radius: 10)
            $0.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(memoLabel, reviewTextView)
        
        memoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

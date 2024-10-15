//
//  RecordBookView.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import Then

final class RecordBookView: UIScrollView {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar()
    let characterView = CharacterView()
    let recordDateView = RecordDateView()
    let bookReviewView = BookReviewView()
    let submitButton = CheckButton()
    private let contentView = UIView()
    
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

extension RecordBookView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .clear
        
        navigationBar.do {
            $0.isTitleLabelIncluded = "퀸의 대각선"
            $0.isTitleViewIncluded = true
            $0.isCloseButtonIncluded = true
        }
        
        submitButton.do {
            $0.setTitle("등록하기", for: .normal)
            $0.setState(.notAllow)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(contentView)
        contentView.addSubviews(navigationBar, characterView, recordDateView,
                         bookReviewView, submitButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        characterView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(210)
        }
        
        recordDateView.snp.makeConstraints {
            $0.top.equalTo(characterView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        bookReviewView.snp.makeConstraints {
            $0.top.equalTo(recordDateView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(220)
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(bookReviewView.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self.snp.width)
            $0.bottom.equalTo(submitButton.snp.bottom)
        }
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentSize = contentView.frame.size
    }
    
    // MARK: - @objc Methods
}

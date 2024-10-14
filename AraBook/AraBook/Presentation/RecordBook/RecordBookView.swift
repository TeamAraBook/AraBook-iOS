//
//  RecordBookView.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import Then

final class RecordBookView: UIView {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar()
    let characterView = CharacterView()
    let recordDateView = RecordDateView()
    private let bookReviewView = BookReviewView()
    private let submitButton = UIButton()
    
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
            $0.setTitle("다음", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
            $0.backgroundColor = .gray200
            $0.makeCornerRound(radius: 16)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(navigationBar, characterView, recordDateView,
                         bookReviewView, submitButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
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
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

//
//  BookDetailDescriptionView.swift
//  AraBook
//
//  Created by KJ on 10/9/24.
//

import UIKit

import SnapKit
import Then

final class BookDetailDescriptionView: UIScrollView {
    
    // MARK: - UI Components
    
    private let pageLabel = UILabel()
    private let bookPageLabel = UILabel()
    
    private let publisherLabel = UILabel()
    private let bookPublisherLabel = UILabel()
    
    private let categoryLabel = UILabel()
    private let bookCategoryLabel = UILabel()
    
    private let hashTagLabel = UILabel()
    
    private let lineView = UIView()
    
    private let bookDescriptionLabel = UILabel()
    
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

extension BookDetailDescriptionView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        pageLabel.do {
            $0.text = "페이지"
            $0.textColor = .black
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        bookPageLabel.do {
            $0.text = "000p"
            $0.textColor = .gray500
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        publisherLabel.do {
            $0.text = "출판사"
            $0.textColor = .black
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        bookPublisherLabel.do {
            $0.text = "열린책들, 2024년"
            $0.textColor = .gray500
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        categoryLabel.do {
            $0.text = "카테고리"
            $0.textColor = .black
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        bookCategoryLabel.do {
            $0.text = "소설"
            $0.textColor = .gray500
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        hashTagLabel.do {
            $0.text = "#해시태그 #이런거"
            $0.textColor = .gray300
            $0.font = .araFont(type: .PretandardRegular, size: 12)
        }
        
        lineView.do {
            $0.backgroundColor = .gray300
        }
        
        bookDescriptionLabel.do {
            $0.text = "기상천외한 이야기를 들려주는\n베르나르베르베르\n개마나르개미개미"
            $0.textColor = .black
            $0.font = .araFont(type: .PretandardRegular, size: 14)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(pageLabel, bookPageLabel,
                    publisherLabel, bookPublisherLabel,
                    categoryLabel, bookCategoryLabel,
                    hashTagLabel, lineView, bookDescriptionLabel)
        
        pageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        bookPageLabel.snp.makeConstraints {
            $0.top.equalTo(pageLabel.snp.bottom).offset(6)
            $0.leading.equalTo(pageLabel)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookPageLabel.snp.bottom).offset(20)
            $0.leading.equalTo(pageLabel)
        }
        
        bookPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(publisherLabel.snp.bottom).offset(6)
            $0.leading.equalTo(pageLabel)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(bookPublisherLabel.snp.bottom).offset(20)
            $0.leading.equalTo(pageLabel)
        }
        
        bookCategoryLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(6)
            $0.leading.equalTo(pageLabel)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.top.equalTo(bookCategoryLabel.snp.bottom).offset(30)
            $0.leading.equalTo(pageLabel)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(hashTagLabel.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(1)
        }
        
        bookDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDescriptionHeight(_ text: String) -> Int {
        let string = text
        let viewSize = Int(string.size(withAttributes: [NSAttributedString.Key.font: UIFont.araFont(type: .PretandardRegular, size: 14)]).height + 5)
        return viewSize
    }
    
    // MARK: - @objc Methods
}

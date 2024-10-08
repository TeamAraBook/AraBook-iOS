//
//  BookCollectionViewCell.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class BookCollectionViewCell: UICollectionViewCell {
    
    private let bookImage = UIImageView()
    private let bookTitle = UILabel()
    private let bookAuthor = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookCollectionViewCell {
     
    func setUI() {
        self.backgroundColor = .clear
        
        bookImage.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 6
        }
        
        bookTitle.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .araFont(type: .PretandardSemiBold, size: 12)
            $0.numberOfLines = 0
        }
        
        bookAuthor.do {
            $0.textColor = .gray500
            $0.textAlignment = .left
            $0.font = .araFont(type: .PretandardRegular, size: 12)
            $0.numberOfLines = 0
        }
    }
    
    func setHierarchy() {
        addSubviews(bookImage,
                    bookTitle,
                    bookAuthor)
    }
    
    func setLayout() {
        bookImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(176)
        }
        
        bookTitle.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        bookAuthor.snp.makeConstraints {
            $0.top.equalTo(bookTitle.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension BookCollectionViewCell {
    
    func bindBestSeller(model: BestSellerBook) {
        bookImage.kf.setImage(with: URL(string: model.coverURL))
        bookTitle.text = model.title
        bookAuthor.text = model.author
    }
}

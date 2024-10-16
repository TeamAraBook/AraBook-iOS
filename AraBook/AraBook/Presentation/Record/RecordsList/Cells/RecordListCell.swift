//
//  RecordListCell.swift
//  AraBook
//
//  Created by KJ on 9/27/24.
//

import UIKit

import SnapKit
import Then

final class RecordListCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let bookImage = UIImageView(image: .imgBook)
    private let titleLabel = UILabel()
    private let recordIcon = UIImageView()
    private let underLine = UIView()
    private let totalReadDate = UILabel()
    private let readingDate = UILabel()
    
    // MARK: - Properties
    
    var bookId: Int = 0
    
    // MARK: - View Life Cycle
    
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

extension RecordListCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.makeCornerRound(radius: 30)
        
        bookImage.do {
            $0.makeShadow(radius: 8, offset: CGSize(width: 0, height: 2), opacity: 0.5)
            $0.makeCornerRound(radius: 8)
        }
        
        titleLabel.do {
            $0.font = .araFont(type: .PretandardBold, size: 18)
            $0.text = "퀸의 대각선"
            $0.textColor = .black
        }
        
        underLine.do {
            $0.backgroundColor = .black
        }
        
        totalReadDate.do {
            $0.text = "총 7일 동안 읽었어요!"
            $0.font = .araFont(type: .PretandardBold, size: 11)
            $0.textColor = .black
        }
        
        readingDate.do {
            $0.text = "23. 11. 25 ~ 24. 09. 20"
            $0.font = .araFont(type: .PretandardRegular, size: 12)
            $0.textColor = .black
        }
        
        recordIcon.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(bookImage, titleLabel, recordIcon,
                         underLine, totalReadDate, readingDate)
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        bookImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(76)
            $0.height.equalTo(125)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.leading.equalTo(bookImage.snp.trailing).offset(11)
        }
        
        recordIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(54)
            $0.height.equalTo(36)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(recordIcon.snp.bottom).offset(4)
            $0.leading.equalTo(bookImage.snp.trailing)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(1)
        }
        
        totalReadDate.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(19)
            $0.leading.equalTo(titleLabel)
        }
        
        readingDate.snp.makeConstraints {
            $0.top.equalTo(totalReadDate.snp.bottom).offset(6)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    // MARK: - Methods
    
    func configureCell(_ model: BookRecordList) {
        bookImage.kf.setImage(with: URL(string: model.coverURL))
        titleLabel.text = model.title
        totalReadDate.text = model.readStartDate
        readingDate.text = model.readEndDate
        totalReadDate.text = "총 \(model.readPeriod)일 동안 읽었어요!"
        bookId = model.reviewID
        recordIcon.kf.setImage(with: URL(string: model.reviewTagIcon))
        backgroundColor = UIColor(hex: model.reviewTagColor)
    }
}

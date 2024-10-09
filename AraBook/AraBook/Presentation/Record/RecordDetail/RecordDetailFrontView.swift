//
//  RecordDetailFrontView.swift
//  AraBook
//
//  Created by 고아라 on 10/1/24.
//

import UIKit

import SnapKit
import Then

final class RecordDetailFrontView: UIView {
    
    // MARK: - UI Components
    
    private let bookBackView = UIView()
    private let bookImageView = UIImageView(image: .imgBook)
    private let bookTitleLabel = UILabel()
    private let divideView = UIView()
    private let bookAuthorLabel = UILabel()
    
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

private extension RecordDetailFrontView {
    
    func setUI() {
        self.do {
            $0.backgroundColor = .chYellow
            $0.makeCornerRound(radius: 50)
        }
        
        bookBackView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 30)
        }
        
        bookImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.makeShadow(radius: 8, offset: CGSize(width: 0, height: 2), opacity: 0.5)
            $0.makeCornerRound(radius: 8)
        }
        
        divideView.do {
            $0.backgroundColor = .black
        }
        
        bookTitleLabel.do {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .araFont(type: .PretandardBold, size: 32)
        }
        
        bookAuthorLabel.do {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .araFont(type: .PretandardSemiBold, size: 20)
        }
    }
    
    func setHierarchy() {
        addSubviews(bookBackView,
                    bookTitleLabel,
                    divideView,
                    bookAuthorLabel)
        bookBackView.addSubview(bookImageView)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 70)
            $0.height.equalTo(558)
        }
        
        bookBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 130)
            $0.height.equalTo(313)
        }
        
        bookImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(148)
            $0.height.equalTo(245)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bookBackView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 118)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 133)
            $0.height.equalTo(1)
        }
        
        bookAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 184)
        }
    }
}

extension RecordDetailFrontView {
    
    func bindFrontView(model: RecordFrontModel) {
        bookTitleLabel.text = model.title
        bookAuthorLabel.text = model.author
    }
}

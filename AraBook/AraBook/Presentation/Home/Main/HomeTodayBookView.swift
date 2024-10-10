//
//  HomeTodayBookView.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class HomeTodayBookView: UIView {
    
    // MARK: - UI Components
    
    private let iconImageView = UIImageView(image: .icRecommend)
    private let titleLabel = UILabel()
    private let todayBookBackView = UIImageView()
    private let backgroundView = UIView()
    private let todayBookImageView = UIImageView()
    private let toayBookTitleLabel = UILabel()
    private let todayBookInfoStackView = UIStackView()
    private let todayBookAuthorLabel = UILabel()
    private let todayBookCategoryLabel = UILabel()
    
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

private extension HomeTodayBookView {
    
    func setUI() {
        titleLabel.do {
            $0.text = "AI가 선정한 오늘의 추천 도서에요!"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .araFont(type: .PyeongChangBold, size: 12)
            $0.clipsToBounds = true
            $0.backgroundColor = .mainGreen
            $0.layer.cornerRadius = 12
        }
        
        todayBookBackView.do {
            $0.contentMode = .center
        }
        
        backgroundView.do {
            $0.backgroundColor = .black.withAlphaComponent(0.5)
        }
        
        todayBookImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 6
        }
        
        toayBookTitleLabel.do {
            $0.textColor = .white
            $0.font = .araFont(type: .PyeongChangBold, size: 14)
        }
        
        todayBookInfoStackView.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        
        [todayBookAuthorLabel, todayBookCategoryLabel].forEach {
            $0.textColor = .white
            $0.font = .araFont(type: .PyeongChangRegular, size: 12)
        }
    }
    
    func setHierarchy() {
        addSubviews(todayBookBackView,
                    iconImageView,
                    titleLabel,
                    todayBookImageView,
                    toayBookTitleLabel,
                    todayBookInfoStackView)
        todayBookBackView.addSubview(backgroundView)
        todayBookInfoStackView.addArrangedSubviews(todayBookAuthorLabel,
                                                   todayBookCategoryLabel)
    }
    
    func setLayout() {
        todayBookBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38)
            $0.leading.equalToSuperview()
            $0.width.equalTo(139)
            $0.height.equalTo(217)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(82)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(-6)
            $0.width.equalTo(188)
            $0.height.equalTo(25)
        }
        
        todayBookImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading).offset(3)
            $0.width.equalTo(117)
            $0.height.equalTo(192)
        }
        
        toayBookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(todayBookImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        todayBookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(toayBookTitleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}

extension HomeTodayBookView {
    
    func bindTodayBook(model: RecommendAiResponseDto){
//        let cropRect = CGRect(x: 0, y: 0,
//                              width: 375,
//                              height: 390)
//        todayBookBackView.loadAndCropImage(from: model.coverURL, cropRect: cropRect)
        todayBookBackView.kf.setImage(with: URL(string: model.coverURL))
        todayBookImageView.kf.setImage(with: URL(string: model.coverURL))
        toayBookTitleLabel.text = model.title
        todayBookAuthorLabel.text = model.author
        todayBookCategoryLabel.text = model.categories.first?.categoryName
    }
}

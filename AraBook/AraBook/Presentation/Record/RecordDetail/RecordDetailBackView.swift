//
//  RecordDetailBackView.swift
//  AraBook
//
//  Created by 고아라 on 10/1/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class RecordDetailBackView: UIView {
    
    // MARK: - UI Components
    
    private let recordIcon = UIImageView(image: .icRecordList)
    private let recordMentLabel = UILabel()
    private let divideView = UIView()
    private let recordContentLabel = UILabel()
    
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

private extension RecordDetailBackView {
    
    func setUI() {
        self.do {
//            $0.backgroundColor = .chYellow
            $0.makeCornerRound(radius: 50)
        }
        
        recordIcon.do {
            $0.contentMode = .scaleAspectFit
        }
        
        recordMentLabel.do {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = .araFont(type: .PretandardBold, size: 32)
        }
        
        divideView.do {
            $0.backgroundColor = .black
        }
        
        recordContentLabel.do {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .araFont(type: .PretandardRegular, size: 18)
        }
    }
    
    func setHierarchy() {
        addSubviews(recordIcon,
                    recordMentLabel,
                    divideView,
                    recordContentLabel)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 70)
            $0.height.equalTo(558)
        }
        
        recordIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(54)
            $0.height.equalTo(36)
        }
        
        recordMentLabel.snp.makeConstraints {
            $0.top.equalTo(recordIcon.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(recordMentLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 133)
            $0.height.equalTo(1)
        }
        
        recordContentLabel.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 148)
        }
    }
}

extension RecordDetailBackView {
    
    func bindBackView(model: RecordDetailResponseDto) {
        recordIcon.kf.setImage(with: URL(string: model.reviewTagIcon))
        recordMentLabel.text = model.reviewTagComment
        recordContentLabel.text = model.content
        backgroundColor = UIColor(hex: model.reviewTagColor)
    }
}

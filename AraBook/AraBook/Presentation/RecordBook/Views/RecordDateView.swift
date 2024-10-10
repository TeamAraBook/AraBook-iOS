//
//  RecordDateView.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import Then

final class RecordDateView: UIView {
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    
    private let startDateLabel = UILabel()
    private let startDate = CalendarView()
    private let endDateLabel = UILabel()
    private let endDate = CalendarView()
    
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

extension RecordDateView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .clear
        
        dateLabel.do {
            $0.text = "언제 읽었나요?"
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
            $0.textColor = .black
        }
        
        startDateLabel.do {
            $0.text = "시작일"
            $0.font = .araFont(type: .PretandardRegular, size: 14)
            $0.textColor = .black
        }
        
        endDateLabel.do {
            $0.text = "종료일"
            $0.font = .araFont(type: .PretandardRegular, size: 14)
            $0.textColor = .black
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(dateLabel, startDateLabel, startDate,
                         endDateLabel, endDate)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        startDateLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.equalTo(dateLabel)
        }
        
        startDate.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(startDateLabel)
            $0.width.equalTo(165)
            $0.height.equalTo(40)
        }
        
        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(startDateLabel)
            $0.leading.equalTo(startDate.snp.trailing).offset(12)
        }
        
        endDate.snp.makeConstraints {
            $0.top.equalTo(startDate)
            $0.leading.equalTo(endDateLabel)
            $0.width.equalTo(165)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

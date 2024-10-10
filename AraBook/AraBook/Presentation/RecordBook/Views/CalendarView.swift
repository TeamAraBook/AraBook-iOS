//
//  CalendarView.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import Then

final class CalendarView: UIView {
    
    // MARK: - UI Components
    
    private let calendarImageView = UIImageView(image: .icCalendar)
    let dateLabel = UILabel()
    
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

extension CalendarView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .gray200
        self.makeCornerRound(radius: 10)
        
        dateLabel.do {
            $0.text = "2024.10.11"
            $0.font = .araFont(type: .PretandardRegular, size: 14)
            $0.textColor = .gray500
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(calendarImageView, dateLabel)
        
        calendarImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(calendarImageView.snp.trailing).offset(8)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

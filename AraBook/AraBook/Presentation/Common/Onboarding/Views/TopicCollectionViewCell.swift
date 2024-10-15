//
//  TopicCollectionViewCell.swift
//  AraBook
//
//  Created by KJ on 10/16/24.
//

import UIKit

import SnapKit
import Then

final class TopicCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TopicCollectionViewCell {
     
    func setUI() {
        self.backgroundColor = .gray500
        self.layer.cornerRadius = 20
        
        titleLabel.do {
            $0.text = "소설"
            $0.font = .araFont(type: .PretandardRegular, size: 15)
            $0.textColor = .white
        }
    }
    
    func setLayout() {
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension TopicCollectionViewCell {
    

}


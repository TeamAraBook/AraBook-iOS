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
    
    let titleLabel = UILabel()
    
    // MARK: - Properties
    
    var categoryId: Int = 0
    
    // MARK: - Initializer
    
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
        self.backgroundColor = .gray400
        self.layer.cornerRadius = self.contentView.frame.height / 2
        
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
    
    // MARK: - Methods
    
    func configureCell(_ model: CategoryMainResponseDTO) {
        titleLabel.text = model.mainCategoryName
        categoryId = model.mainCategoryId
    }
    
    func setSelectedCell() {
        self.backgroundColor = .chGreen
    }
}


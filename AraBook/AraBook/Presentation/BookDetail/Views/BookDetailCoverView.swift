//
//  BookDetailCoverView.swift
//  AraBook
//
//  Created by KJ on 10/9/24.
//

import UIKit

import SnapKit
import Then

final class BookDetailCoverView: UIScrollView {
    
    // MARK: - UI Components
    
    private let bookBackgroundImageView = UIImageView(image: .imgBook)
    private let bookImageView = UIImageView(image: .imgBook)
    private let bookTitleLabel = UILabel()
    private let authorLabel = UILabel()
    
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

extension BookDetailCoverView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

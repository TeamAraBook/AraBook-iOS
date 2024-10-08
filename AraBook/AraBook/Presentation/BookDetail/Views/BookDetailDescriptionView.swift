//
//  BookDetailDescriptionView.swift
//  AraBook
//
//  Created by KJ on 10/9/24.
//

import UIKit

import SnapKit
import Then

final class BookDetailDescriptionView: UIScrollView {
    
    // MARK: - UI Components
    
    private let pageLabel = UILabel()
    private let bookPageLabel = UILabel()
    private let publisherLabel = UILabel()
    private let bookPublisherLabel = UILabel()
    private let bookPublicationYear = UILabel()
    private let bookDescriptionLabel = UILabel()
    
    private let categoryLabel = UILabel()
    private let hashTagLabel = UILabel()
    
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

extension BookDetailDescriptionView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

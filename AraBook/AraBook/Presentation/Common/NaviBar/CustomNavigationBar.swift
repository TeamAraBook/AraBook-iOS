//
//  CustomNavigationBar.swift
//  AraBook
//
//  Created by 고아라 on 9/24/24.
//

import UIKit

import Then
import SnapKit

final class CustomNavigationBar: UIView {
    
    // MARK: - UI Components

    private lazy var titleView = UIView()
    lazy var titleLabel = UILabel()
    private lazy var backButton = UIButton()
    private lazy var closeButton = UIButton()
    private lazy var whiteBackButton = UIButton()
    private lazy var moreButton = UIButton()
    
    // MARK: - Properties
    
    var isTitleLabelIncluded: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var isTitleViewIncluded: Bool {
        get { !titleView.isHidden }
        set { titleView.isHidden = !newValue }
    }
    
    var isBackButtonIncluded: Bool {
        get { !backButton.isHidden }
        set { backButton.isHidden = !newValue }
    }
    
    var isCloseButtonIncluded: Bool {
        get { !closeButton.isHidden }
        set { closeButton.isHidden = !newValue }
    }
    
    var isWhiteBackButtonIncluded: Bool {
        get { !whiteBackButton.isHidden }
        set { whiteBackButton.isHidden = !newValue }
    }
    
    var isMoreButtonIncluded: Bool {
        get { !moreButton.isHidden }
        set { moreButton.isHidden = !newValue }
    }
    
    var backButtonAction: (() -> Void)?
    var closeButtonAction: (() -> Void)?
    var moreButtonAction: (() -> Void)?
    var whiteBackButtonAction: (() -> Void)?
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomNavigationBar {
    
    func setUI() {

        self.backgroundColor = .white
        
        titleView.do {
            $0.isHidden = true
        }
        
        titleLabel.do {
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        backButton.do {
            $0.setImage(.icBack, for: .normal)
            $0.isHidden = true
        }
        
        closeButton.do {
            $0.setImage(.icClose, for: .normal)
            $0.isHidden = true
            $0.isEnabled = true
        }
        
        whiteBackButton.do {
            $0.setImage(.icBackWhite, for: .normal)
            $0.isHidden = true
            $0.isEnabled = true
        }
        
        moreButton.do {
            $0.setImage(.btnMore, for: .normal)
            $0.isHidden = true
            $0.isEnabled = true
        }
    }
    
    func setHierarchy() {
        
        self.addSubviews(backButton, closeButton, titleView, whiteBackButton, moreButton)
        titleView.addSubview(titleLabel)
    }
    
    func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 48 / 812)
        }
        
        titleView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        whiteBackButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
    }
    
    func setAddTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        closeButton.addTarget(self,
                              action: #selector(closeButtonTapped),
                              for: .touchUpInside)
        moreButton.addTarget(self,
                             action: #selector(moreButtonTapped),
                             for: .touchUpInside)
        whiteBackButton.addTarget(self,
                             action: #selector(whiteBackButtonTapped),
                             for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        backButtonAction?()
    }
    
    @objc
    func closeButtonTapped() {
        closeButtonAction?()
    }
    
    @objc
    func moreButtonTapped() {
        moreButtonAction?()
    }
    
    @objc
    func whiteBackButtonTapped() {
        whiteBackButtonAction?()
    }
}

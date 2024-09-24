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
    private lazy var titleLabel = UILabel()
    private lazy var backButton = UIButton()
    private lazy var closeButton = UIButton()
    
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
    
    var backButtonAction: (() -> Void)?
    var closeButtonAction: (() -> Void)?
    
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
    }
    
    func setHierarchy() {
        
        self.addSubviews(backButton, closeButton, titleView)
        titleView.addSubview(titleLabel)
    }
    
    func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 48 / 812)
        }
        
        titleView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
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
    }
    
    // TODO: combine으로 바꾸기
    
    func setAddTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        closeButton.addTarget(self,
                              action: #selector(closeButtonTapped),
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
}

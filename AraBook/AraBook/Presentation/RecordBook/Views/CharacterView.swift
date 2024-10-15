//
//  CharacterView.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import Then

enum CharacterType {
    case notMuch
    case littleBit
    case normal
    case fun
    case lifeBook
    case none // Default value
}

final class CharacterView: UIView {
    
    // MARK: - UI Components
    
    private let characterLabel = UILabel()
    
    private let buttonView = UIView()
    let notMuchButton = UIButton()
    let littleBitButton = UIButton()
    let normalButton = UIButton()
    let funButton = UIButton()
    let lifeBookButton = UIButton()
    
    let pickLabel = UILabel()
    
    // MARK: - Properties
    
    private var selectedButton: UIButton?
    
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

extension CharacterView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .clear
        
        characterLabel.do {
            $0.text = "캐릭터를 골라주세요!"
            $0.textColor = .black
            $0.font = .araFont(type: .PretandardSemiBold, size: 16)
        }
        
        notMuchButton.do {
            $0.setImage(.unSelectedNotMuch, for: .normal)
            $0.setImage(.selectedNotMuch, for: .selected)
        }
        
        littleBitButton.do {
            $0.setImage(.unSelectedLittleBit, for: .normal)
            $0.setImage(.selectedLittleBit, for: .selected)
        }
        
        normalButton.do {
            $0.setImage(.unSelectedNormal, for: .normal)
            $0.setImage(.selectedNormal, for: .selected)
        }
        
        funButton.do {
            $0.setImage(.unSelectedFun, for: .normal)
            $0.setImage(.selectedFun, for: .selected)
        }
        
        lifeBookButton.do {
            $0.setImage(.unSelectedLifeBook, for: .normal)
            $0.setImage(.selectedLifeBook, for: .selected)
        }
        
        pickLabel.do {
            $0.text = "선택 전입니다."
            $0.isHidden = true
            $0.font = .araFont(type: .PretandardRegular, size: 16)
            $0.textColor = .chGreen
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(characterLabel, pickLabel, buttonView)
        buttonView.addSubviews(notMuchButton, littleBitButton, normalButton, funButton, lifeBookButton)
        
        characterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        pickLabel.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(5)
            $0.leading.equalTo(characterLabel)
        }
        
        buttonView.snp.makeConstraints {
            $0.top.equalTo(pickLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(120)
        }
        
        notMuchButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        littleBitButton.snp.makeConstraints {
            $0.bottom.equalTo(notMuchButton)
            $0.leading.equalTo(notMuchButton.snp.trailing).offset(10)
        }
        
        normalButton.snp.makeConstraints {
            $0.bottom.equalTo(notMuchButton)
            $0.leading.equalTo(littleBitButton.snp.trailing).offset(10)
        }
        
        funButton.snp.makeConstraints {
            $0.bottom.equalTo(notMuchButton)
            $0.leading.equalTo(normalButton.snp.trailing).offset(10)
        }
        
        lifeBookButton.snp.makeConstraints {
            $0.bottom.equalTo(notMuchButton)
            $0.leading.equalTo(funButton.snp.trailing).offset(10)
        }
    }
    
    // MARK: - Methods
    
    func updateButtonSelection(_ model: CharacterModel) {
        notMuchButton.isSelected = (model.type == .notMuch)
        littleBitButton.isSelected = (model.type == .littleBit)
        normalButton.isSelected = (model.type == .normal)
        funButton.isSelected = (model.type == .fun)
        lifeBookButton.isSelected = (model.type == .lifeBook)
        
        pickLabel.isHidden = false
        pickLabel.text = model.text
        pickLabel.textColor = model.color
    }
    
    // MARK: - @objc Methods

}

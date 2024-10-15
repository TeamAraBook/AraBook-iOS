//
//  FirstOnboardingView.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import UIKit

import SnapKit
import Then

enum GenderType {
    case man
    case woman
    case none
}

final class FirstOnboardingView: UIView {
    
    // MARK: - UI Components
    
    private let araBookDescriptionLabel = UILabel()
    private let recommendLabel = UILabel()
    private let nicknameLabel = UILabel()
    let nicknameTextField = UITextField()
    let birthYearTextField = UITextField()
    private let birthYearLabel = UILabel()
    
    private let genderLabel = UILabel()
    let manButton = UIButton()
    let womanButton = UIButton()
    let unSelectGenderButton = UIButton()
    
    let nextButton = CheckButton()
    
    // MARK: - Properties
    
    var selectedGender: GenderType = .man {
        didSet {
            updateGenderSelectionUI()
        }
    }
    
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

extension FirstOnboardingView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .white
        
        araBookDescriptionLabel.do {
            $0.text = "아라북은 여러분이 궁금해요"
            $0.textColor = .black
            $0.font = .araFont(type: .PyeongChangBold, size: 27)
        }
        
        recommendLabel.do {
            $0.text = "입력한 정보를 기반으로 도서를 추천해줄게요!"
            $0.textColor = .gray500
            $0.font = .araFont(type: .PyeongChangBold, size: 15)
        }
        
        nicknameLabel.do {
            $0.text = "닉네임과 출생년도를 알려주세요!"
            $0.textColor = .gray800
            $0.font = .araFont(type: .PretandardSemiBold, size: 25)
        }
        
        nicknameTextField.do {
            $0.placeholder = "예시) 으나"
            $0.textColor = .black
            $0.font = .araFont(type: .PyeongChangBold, size: 20)
            $0.makeCornerRound(radius: 20)
            $0.layer.borderColor = UIColor.chGreen.cgColor
            $0.layer.borderWidth = 2
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
            $0.leftViewMode = .always
        }
        
        birthYearTextField.do {
            $0.textColor = .black
            $0.font = .araFont(type: .PyeongChangBold, size: 20)
            $0.makeCornerRound(radius: 20)
            $0.layer.borderColor = UIColor.chGreen.cgColor
            $0.layer.borderWidth = 2
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.frame.size.height))
            $0.leftViewMode = .always
        }
        
        birthYearLabel.do {
            $0.text = "년생"
            $0.textColor = .gray800
            $0.font = .araFont(type: .PyeongChangBold, size: 25)
        }
        
        genderLabel.do {
            $0.text = "성별에 대해 알려주세요!"
            $0.textColor = .gray800
            $0.font = .araFont(type: .PyeongChangBold, size: 25)
        }
        
        manButton.do {
            $0.setTitle("남자", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .gray500
            $0.titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
            $0.makeCornerRound(radius: 20)
        }
        
        womanButton.do {
            $0.setTitle("여자", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .gray500
            $0.titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
            $0.makeCornerRound(radius: 20)
        }
        
        unSelectGenderButton.do {
            $0.setTitle("선택안함", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .gray500
            $0.titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
            $0.makeCornerRound(radius: 20)
        }
        
        nextButton.do {
            $0.setTitle("다음", for: .normal)
            $0.setState(.allow)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.addSubviews(araBookDescriptionLabel, recommendLabel,
                         nicknameLabel, nicknameTextField,
                         birthYearTextField, birthYearLabel,
                         genderLabel, manButton, womanButton, unSelectGenderButton,
                         nextButton)
        
        araBookDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(araBookDescriptionLabel.snp.bottom).offset(3)
            $0.leading.equalTo(araBookDescriptionLabel)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(recommendLabel.snp.bottom).offset(45)
            $0.leading.equalTo(araBookDescriptionLabel)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        birthYearTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(15)
            $0.leading.equalTo(araBookDescriptionLabel)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        birthYearLabel.snp.makeConstraints {
            $0.top.equalTo(birthYearTextField).offset(2)
            $0.leading.equalTo(birthYearTextField.snp.trailing).offset(5)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(birthYearTextField.snp.bottom).offset(42)
            $0.leading.equalTo(recommendLabel)
        }
        
        manButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(85)
            $0.height.equalTo(45)
        }
        
        womanButton.snp.makeConstraints {
            $0.top.equalTo(manButton)
            $0.leading.equalTo(manButton.snp.trailing).offset(10)
            $0.width.equalTo(85)
            $0.height.equalTo(45)
        }
        
        unSelectGenderButton.snp.makeConstraints {
            $0.top.equalTo(manButton)
            $0.leading.equalTo(womanButton.snp.trailing).offset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(45)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Methods
    
    func selectedGenderButton(_ type: GenderType) {
        selectedGender = type
    }
    
    private func updateGenderSelectionUI() {
        resetButtonColors()
        
        switch selectedGender {
        case .man:
            manButton.backgroundColor = .chGreen
        case .woman:
            womanButton.backgroundColor = .chGreen
        case .none:
            unSelectGenderButton.backgroundColor = .chGreen
        }
    }
    
    private func resetButtonColors() {
        manButton.backgroundColor = .gray500
        womanButton.backgroundColor = .gray500
        unSelectGenderButton.backgroundColor = .gray500
    }
}

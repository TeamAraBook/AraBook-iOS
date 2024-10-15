//
//  OnboardingViewModel.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol OnboardingViewModelInputs {
    func genderButtonTapped(_ type: GenderType)
    func userInfo(_ model: OnboardingUserInfo)
}

protocol OnboardingViewModelOutputs {
    var selectedGenderType: BehaviorRelay<GenderType> { get }
    
}

protocol OnboardingViewModelType {
    var inputs: OnboardingViewModelInputs { get }
    var outputs: OnboardingViewModelOutputs { get }
}

final class OnboardingViewModel: OnboardingViewModelInputs, OnboardingViewModelOutputs, OnboardingViewModelType {
    
    private let disposeBag = DisposeBag()
    
    var selectedGenderType: BehaviorRelay<GenderType> = BehaviorRelay<GenderType>(value: .man)
    var nickname: String = ""
    var birth: String = ""
    var gender: GenderType = .man
    
    var inputs: OnboardingViewModelInputs { return self }
    var outputs: OnboardingViewModelOutputs { return self }
    
    init() {

    }
}

extension OnboardingViewModel {
    
    func genderButtonTapped(_ type: GenderType) {
        self.selectedGenderType.accept(type)
    }
    
    func userInfo(_ model: OnboardingUserInfo) {
        self.nickname = model.nickname
        self.birth = model.birth
        self.gender = model.gender
        print(model, "유저정보 저장")
    }
}

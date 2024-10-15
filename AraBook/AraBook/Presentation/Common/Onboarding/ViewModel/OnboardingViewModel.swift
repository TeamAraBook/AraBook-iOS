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
    
    var inputs: OnboardingViewModelInputs { return self }
    var outputs: OnboardingViewModelOutputs { return self }
    
    init() {

    }
}

extension OnboardingViewModel {
    
    func genderButtonTapped(_ type: GenderType) {
        self.selectedGenderType.accept(type)
    }
}

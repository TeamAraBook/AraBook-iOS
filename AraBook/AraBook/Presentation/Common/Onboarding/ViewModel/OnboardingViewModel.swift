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

}

protocol OnboardingViewModelOutputs {

}

protocol OnboardingViewModelType {
    var inputs: OnboardingViewModelInputs { get }
    var outputs: OnboardingViewModelOutputs { get }
}

final class OnboardingViewModel: OnboardingViewModelInputs, OnboardingViewModelOutputs, OnboardingViewModelType {
    
    private let disposeBag = DisposeBag()
    
    var inputs: OnboardingViewModelInputs { return self }
    var outputs: OnboardingViewModelOutputs { return self }
    
    init() {

    }
    

}

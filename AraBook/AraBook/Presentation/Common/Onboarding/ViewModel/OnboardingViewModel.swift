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
    func getCategoryMain()
    func getCategorySub(_ list: [Int])
}

protocol OnboardingViewModelOutputs {
    var selectedGenderType: BehaviorRelay<GenderType> { get }
    var categoryMain: BehaviorRelay<[CategoryMainResponseDTO]> { get }
    var categorySub: BehaviorRelay<[CategorySubResponseDTO]> { get }
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
    
    var categoryMain: BehaviorRelay<[CategoryMainResponseDTO]> = BehaviorRelay<[CategoryMainResponseDTO]>(value: [])
    var categorySub: BehaviorRelay<[CategorySubResponseDTO]> = BehaviorRelay<[CategorySubResponseDTO]>(value: [])
    
    var inputs: OnboardingViewModelInputs { return self }
    var outputs: OnboardingViewModelOutputs { return self }
    
    init() {
        getCategoryMain()
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
    
    func getCategoryMain() {
        OnboardingService.getCategoryMain()
            .subscribe(onNext:  { [weak self] data in
                guard let self else { return }
                self.categoryMain.accept(data)
            })
            .disposed(by: disposeBag)
    }
    
    func getCategorySub(_ list: [Int]) {
        var query = list.map { String($0) }.joined(separator: ",")
        OnboardingService.getCategorySub(query)
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                self.categorySub.accept(data)
            })
            .disposed(by: disposeBag)
    }
}

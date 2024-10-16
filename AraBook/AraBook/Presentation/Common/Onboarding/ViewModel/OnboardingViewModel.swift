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
    func putOnboarding(_ list: [Int])
}

protocol OnboardingViewModelOutputs {
    var selectedGenderType: BehaviorRelay<GenderType> { get }
    var categoryMain: BehaviorRelay<[CategoryMainResponseDTO]> { get }
    var categorySub: BehaviorRelay<[CategorySubResponseDTO]> { get }
    var category1: BehaviorRelay<[SubCategoryLists]> { get }
    var category2: BehaviorRelay<[SubCategoryLists]> { get }
    var category3: BehaviorRelay<[SubCategoryLists]> { get }
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
    
    var category1: BehaviorRelay<[SubCategoryLists]> = BehaviorRelay(value: [])
    var category2: BehaviorRelay<[SubCategoryLists]> = BehaviorRelay(value: [])
    var category3: BehaviorRelay<[SubCategoryLists]> = BehaviorRelay(value: [])
    
    var mainCategoryList: [Int] = [1, 2, 3]
    var subCategory1: [SubCategoryLists] = [SubCategoryLists(subCategoryId: 11, subCategoryName: "제발")]
    var subCategoryList: [Int] = []
    
    var inputs: OnboardingViewModelInputs { return self }
    var outputs: OnboardingViewModelOutputs { return self }
    
    init() {
        getCategoryMain()
        getCategorySub(mainCategoryList)
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
        mainCategoryList = list
        let query = list.map { String($0) }.joined(separator: ",")
        OnboardingService.getCategorySub(query)
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                
                let categoryData = data.map { category in
                    return (category.mainCategoryId, category.mainCategoryName, category.subCategories)
                }
                
                self.category1.accept(categoryData[0].2)
                self.category2.accept(categoryData[1].2)
                self.category3.accept(categoryData[2].2)
                
                self.categorySub.accept(data)
            })
            .disposed(by: disposeBag)
    }
    
    func putOnboarding(_ list: [Int]) {
        let dto = OnboardingRequestDTO(nickname: self.nickname, gender: "WOMAN", birthYear: genderBind(self.gender), interestSubCategoryIds: list)
        
        OnboardingService.putOnboarding(dto)
            .subscribe(onNext: { data in
                print("성공서 ㅇ속ㅇ성공것옷", data)
            })
            .disposed(by: disposeBag)
    }
    
    private func genderBind(_ type: GenderType) -> String {
        switch type {
        case .man:
            return "MAN"
        case .woman:
            return "WOMAN"
        case .none:
            return "UNKNOWN"
        }
    }
}

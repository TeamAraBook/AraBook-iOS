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
    
    var inputs: OnboardingViewModelInputs { return self }
    var outputs: OnboardingViewModelOutputs { return self }
    
    init() {
        getCategoryMain()
        getCategorySub(mainCategoryList)
        category1.accept(subCategory1)
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
                
                
                subCategory1 = categoryData[0].2
                self.category1.accept(categoryData[0].2)
                    print("✅ category1Data:", categoryData)
                    self.category2.accept(categoryData[1].2)
                    self.category3.accept(categoryData[2].2)
                
                self.categorySub.accept(data)
            })
            .disposed(by: disposeBag)
    }
}

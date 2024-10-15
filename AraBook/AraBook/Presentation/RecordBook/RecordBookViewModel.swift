//
//  RecordBookViewModel.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import RxSwift
import RxCocoa

protocol RecordBookViewModelDelegate: AnyObject {
    func didUpdateStartDate(_ date: String)
    func didUpdateEndDate(_ date: String)
}

final class RecordBookViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    weak var delegate: RecordBookViewModelDelegate?
    
    init() {
        
    }
    
    struct Input {
//        let viewWillAppear: PublishRelay<Void>
        let characterButtonTapped: BehaviorRelay<CharacterType>
        let startDate: PublishRelay<String>
        let endDate: PublishRelay<String>
        let reviewText: Observable<String>
        let checkButton: PublishRelay<Void>
    }
    
    struct Output {
        let selectedCharacter: PublishRelay<CharacterModel> = PublishRelay<CharacterModel>()
        var startDate: PublishRelay<String> = PublishRelay<String>()
        var enableButton: Observable<Bool> = Observable<Bool>.just(false)
    }
    
    func transform(input: Input) -> Output {
        var output = Output()
        
//        input.viewWillAppear
//            .subscribe(with: self, onNext: { owner, _ in
//                // viewWillAppear 시 필요한 동작을 여기에 추가 가능
//            })
//            .disposed(by: disposeBag)
        
        input.characterButtonTapped
            .bind(with: self, onNext: { owner, type in
                owner.selectedCharacter(with: type, output: output)
            })
            .disposed(by: disposeBag)
        
        input.startDate
            .subscribe(onNext: { date in
                output.startDate.accept(date)
            })
            .disposed(by: disposeBag)
        
        input.startDate
            .subscribe(onNext: { [weak self] date in
                self?.delegate?.didUpdateStartDate(date)
            })
            .disposed(by: disposeBag)

        input.endDate
            .subscribe(onNext: { [weak self] date in
                self?.delegate?.didUpdateEndDate(date) // Delegate 호출
            })
            .disposed(by: disposeBag)
        
        let isCharacterSelected = input.characterButtonTapped
            .map { $0 != .none }  // 캐릭터가 선택되었는지 체크
        
        let isStartDateValid = input.startDate
            .map { !$0.isEmpty }  // 시작 날짜가 유효한지 체크
        
        let isEndDateValid = input.endDate
            .map { !$0.isEmpty }  // 종료 날짜가 유효한지 체크
        
        let isReviewTextValid = input.reviewText
            .map { !$0.isEmpty && $0 != "책에 대한 간단한 소감을 적어주세요." }  // 리뷰 텍스트가 유효한지 체크
        
        output.enableButton = Observable
            .combineLatest(isCharacterSelected, isStartDateValid, isEndDateValid, isReviewTextValid)
            .map { $0 && $1 && $2 && $3 }  // 네 가지 조건이 모두 충족되었을 때 true
            .asObservable()
        
        return output
    }
    
    private func selectedCharacter(with type: CharacterType, output: Output) {
        var text: String = ""
        var color: UIColor = .clear
        
        switch type {
        case .notMuch:
            text = "별로였어.."
            color = .chYellow
        case .littleBit:
            text = "조금 아쉬웠어.."
            color = .chOrange
        case .normal:
            text = "평범했어."
            color = .chBlue
        case .fun:
            text = "재밌었어!"
            color = .chGreen
        case .lifeBook:
            text = "내 인생책이야!"
            color = .chRed
        default:
            text = ""
            color = .clear
        }
        
        let character = CharacterModel(type: type, text: text, color: color)
        output.selectedCharacter.accept(character)
    }
    
    func updateStartDate(date: String) {
        delegate?.didUpdateStartDate(date)
    }
    
    func updateEndDate(date: String) {
        delegate?.didUpdateEndDate(date)
    }
}

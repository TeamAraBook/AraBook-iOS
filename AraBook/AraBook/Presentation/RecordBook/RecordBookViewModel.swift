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
        let startDate: BehaviorRelay<String>
        let endDate: BehaviorRelay<String>
    }
    
    struct Output {
        let selectedCharacter: PublishRelay<CharacterModel> = PublishRelay<CharacterModel>()
        var startDate: PublishRelay<String> = PublishRelay<String>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
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
            .subscribe(onNext: { [weak self] date in
                self?.delegate?.didUpdateStartDate(date) // Delegate 호출
            })
            .disposed(by: disposeBag)

        input.endDate
            .subscribe(onNext: { [weak self] date in
                self?.delegate?.didUpdateEndDate(date) // Delegate 호출
            })
            .disposed(by: disposeBag)
        
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

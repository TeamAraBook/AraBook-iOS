//
//  RecordBookViewModel.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import RxSwift
import RxCocoa

final class RecordBookViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
    
    struct Input {
//        let viewWillAppear: PublishRelay<Void>
        let characterButtonTapped: BehaviorRelay<CharacterType>
    }
    
    struct Output {
        let selectedCharacter: PublishRelay<CharacterModel> = PublishRelay<CharacterModel>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        // Input의 viewWillAppear와 characterButtonTapped 처리
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
}

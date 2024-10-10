//
//  RecordBookViewModel.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import RxSwift
import RxCocoa

final class RecordBookViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppear: PublishRelay<Void>
    }
    
    struct Output {

    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension RecordBookViewModel {
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        
    }
}

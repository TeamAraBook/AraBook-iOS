//
//  RecordListViewModel.swift
//  AraBook
//
//  Created by KJ on 9/27/24.
//

import RxSwift
import RxCocoa

final class RecordListViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppear: PublishRelay<Void>
    }
    
    struct Output {
        let recordListData = PublishRelay<[RecordListModel]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                output.recordListData.accept(RecordListModel.dummy())
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension RecordListViewModel {
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        
    }
}

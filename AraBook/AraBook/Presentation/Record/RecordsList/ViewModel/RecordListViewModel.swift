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
        let detailViewWillAppear: PublishRelay<Void>
    }
    
    struct Output {
        let recordListData = PublishRelay<[RecordListModel]>()
        let recordFrontData = PublishRelay<RecordFrontModel>()
        let recordBackData = PublishRelay<RecordBackModel>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                output.recordListData.accept(RecordListModel.dummy())
            })
            .disposed(by: disposeBag)
        
        input.detailViewWillAppear
            .subscribe(with: self, onNext: { owner, index in
                print(index)
                output.recordFrontData.accept(RecordFrontModel.dummy())
                output.recordBackData.accept(RecordBackModel.dummy())
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension RecordListViewModel {
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        
    }
}

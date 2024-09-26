//
//  HomeViewModel.swift
//  AraBook
//
//  Created by 고아라 on 9/27/24.
//

import RxSwift
import RxCocoa

final class HomeViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppear: PublishRelay<Void>
    }
    
    struct Output {
        let todayBookData = PublishRelay<TodayBookModel>()
        let bestSellerData = PublishRelay<[BestSellerModel]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                output.todayBookData.accept(TodayBookModel.dummy())
                output.bestSellerData.accept(BestSellerModel.dummy())
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension HomeViewModel {
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        
    }
}

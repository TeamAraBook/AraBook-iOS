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
    private let homeService: HomeService
    
    init(homeService: HomeService = HomeService.shared) {
        self.homeService = homeService
    }
    
    struct Input {
        let viewWillAppear: PublishRelay<Void>
    }
    
    struct Output {
        let homeAiData = PublishRelay<RecommendAiResponseDto>()
        let homeBestSellerData = PublishRelay<[BestSellerBook]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        bindOutput(output: output)
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                owner.bindOutput(output: output)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output) {
        homeService.getHomeAi { response in
            guard let data = response?.data else { return }
            output.homeAiData.accept(data)
        }
        
        homeService.getHomeBestSeller {  response in
            guard let data = response?.data else { return }
            output.homeBestSellerData.accept(data.books)
        }
    }
}

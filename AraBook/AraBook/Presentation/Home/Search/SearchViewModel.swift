//
//  SearchViewModel.swift
//  AraBook
//
//  Created by 고아라 on 10/9/24.
//

import RxSwift
import RxCocoa

final class SearchViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    private let homeService: HomeService
    
    init(homeService: HomeService = HomeService.shared) {
        self.homeService = homeService
    }
    
    struct Input {
        let viewWillAppear: PublishRelay<Void>
        let searchTapped: PublishRelay<String>
    }
    
    struct Output {
        let bookSearchCount = PublishRelay<Int>()
        let bookSearchData = PublishRelay<[SearchBook]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
//        bindOutput(output: output)
        
//        input.viewWillAppear
//            .subscribe(with: self, onNext: { owner, _ in
//                owner.bindOutput(output: output)
//            })
//            .disposed(by: disposeBag)
        
        input.searchTapped
            .subscribe(with: self, onNext: { owner, keyword in
                owner.searchBook(with: keyword, output: output)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func searchBook(with keyword: String, output: Output) {
        homeService.getSearchBook(keyword: keyword) { response in
            guard let data = response?.data else { return }
            output.bookSearchData.accept(data.books)
            output.bookSearchCount.accept(data.totalCount)
        }
    }
}

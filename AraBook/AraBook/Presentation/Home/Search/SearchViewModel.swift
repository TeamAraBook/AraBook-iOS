//
//  SearchViewModel.swift
//  AraBook
//
//  Created by 고아라 on 10/9/24.
//

import Foundation

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
        let showRecent: PublishRelay<Void>
    }
    
    struct Output {
        let bookSearchCount = PublishRelay<Int>()
        let bookSearchData = PublishRelay<[SearchBook]>()
        let recentSearchData = PublishRelay<[RecentSearchInfo]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.searchTapped
            .subscribe(with: self, onNext: { owner, keyword in
                owner.searchBook(with: keyword, output: output)
            })
            .disposed(by: disposeBag)
        
        input.showRecent
            .subscribe(with: self, onNext: { owner, keyword in
                owner.getRecentSearchData(output: output)
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
    
    private func getRecentSearchData(output: Output) {
        let recentSearches = LocalDBService.shared.getData()
        DispatchQueue.main.async {
            output.recentSearchData.accept(recentSearches)
        }
    }
}

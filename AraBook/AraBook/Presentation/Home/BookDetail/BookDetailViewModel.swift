//
//  BookDetailViewModel.swift
//  AraBook
//
//  Created by KJ on 10/7/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol BookDetailViewModelInputs {
    func getBookDetail(_ bookId: Int)
}

protocol BookDetailViewModelOutputs {
    var bindBookDetail: PublishRelay<BookDetailResponseDTO> { get }
}

protocol BookDetailViewModelType {
    var inputs: BookDetailViewModelInputs { get }
    var outputs: BookDetailViewModelOutputs { get }
}

final class BookDetailViewModel: BookDetailViewModelInputs, BookDetailViewModelOutputs, BookDetailViewModelType {
    
    private let disposeBag = DisposeBag()
    
    var bindBookDetail: PublishRelay<BookDetailResponseDTO> = PublishRelay<BookDetailResponseDTO>()
    
    var inputs: BookDetailViewModelInputs { return self }
    var outputs: BookDetailViewModelOutputs { return self }
    
    init() {
    }
}

extension BookDetailViewModel {
    
    func getBookDetail(_ bookId: Int) {
        RecordBookService.getBookDetail(bookId: bookId)
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                self.bindBookDetail.accept(data)
            })
            .disposed(by: disposeBag)
    }
}

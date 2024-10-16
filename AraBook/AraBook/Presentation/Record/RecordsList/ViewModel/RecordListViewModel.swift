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
    let bindBookList = PublishRelay<BookRecordResponseDTO>()
    private var selectReviewId: Int?
    
    struct Input {
        let viewWillAppear: PublishRelay<Void>
        let selectRecordList: PublishRelay<Int>
        let detailViewWillAppear: PublishRelay<Void>
    }
    
    struct Output {
        let recordListData = PublishRelay<BookRecordResponseDTO>()
        let recordDetailData = PublishRelay<RecordDetailResponseDto>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                self.getRecordBookList()
            })
            .disposed(by: disposeBag)
        
        input.detailViewWillAppear
            .subscribe(with: self, onNext: { owner, index in
                owner.getBookRecordDetail(reviewId: self.selectReviewId ?? 0,
                                          output: output,
                                          disposeBag: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        input.selectRecordList
            .subscribe(with: self, onNext: { owner, index in
                self.selectReviewId = index
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension RecordListViewModel {
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        
    }
    
    func getRecordBookList() {
        RecordBookService.getBookRecordList()
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                self.bindBookList.accept(data)
            })
            .disposed(by: disposeBag)
    }
    
    func getBookRecordDetail(reviewId: Int, output: Output, disposeBag: DisposeBag) {
        RecordBookService.getBookRecordDetail(reviewId: reviewId)
            .subscribe(onNext: { data in
                output.recordDetailData.accept(data)
            })
            .disposed(by: disposeBag)
    }
}

//
//  RecordBookService.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

struct RecordBookService: Networkable {
    
    typealias Target = RecordTarget
    private static let provider = makeProvider()
    
    static func postReviews(dto: RecordBookRequestDTO) -> Observable<RecordBookResponseDTO> {
        return provider.rx.request(.postReviews(dto: dto))
            .asObservable()
            .mapError()
            .decode(decodeType: RecordBookResponseDTO.self)
    }
    
    static func getBookDetail(bookId: Int) -> Observable<BookDetailResponseDTO> {
        return provider.rx.request(.getBookDetail(bookId: bookId))
            .asObservable()
            .mapError()
            .decode(decodeType: BookDetailResponseDTO.self)
    }
    
    static func getBookRecordList() -> Observable<BookRecordResponseDTO> {
        return provider.rx.request(.getRecordBookList)
            .asObservable()
            .mapError()
            .decode(decodeType: BookRecordResponseDTO.self)
    }
    
    static func getBookRecordDetail(reviewId: Int) -> Observable<RecordDetailResponseDto> {
        return provider.rx.request(.getRecordBookDetail(reviewId: reviewId))
            .asObservable()
            .mapError()
            .decode(decodeType: RecordDetailResponseDto.self)
    }
}

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

enum RecordBookTarget {
    
    case getBookDetail(bookId: Int)
    case postReviews(dto: RecordBookRequestDTO)
    case getRecordBookList
}

extension RecordBookTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .postReviews:
            return URLConstant.reviews
        case .getBookDetail(let bookId):
            let path = URLConstant.bookDetail
                .replacingOccurrences(of: "{bookId}", with: String(bookId))
            return path
        case .getRecordBookList:
            return URLConstant.reviews
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReviews:
            return .post
        case .getBookDetail:
            return .get
        case .getRecordBookList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postReviews(let dto):
            return .requestJSONEncodable(dto)
        case .getBookDetail:
            return .requestPlain
        case .getRecordBookList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.hasTokenHeader
    }
}

struct RecordBookService: Networkable {
    
    typealias Target = RecordBookTarget
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
}

struct RecordBookRequestDTO: Codable {
    let bookId: Int
    let reviewTag: String
    let content: String
    let readStartDate: String
    let readEndDate: String
}

struct RecordBookResponseDTO: Codable {
    let reviewId: Int
}

struct BookDetailResponseDTO: Codable {
    let bookID: Int
    let coverURL: String
    let title, author, publisher, publicationYear: String
    let description: String
    let categories: [BookCategory]
    let hashtags: [BookHashtag]

    enum CodingKeys: String, CodingKey {
        case bookID = "bookId"
        case coverURL = "coverUrl"
        case title, author, publisher, publicationYear, description, categories, hashtags
    }
}

// MARK: - Category
struct BookCategory: Codable {
    let subCategoryID: Int
    let subCategoryName: String

    enum CodingKeys: String, CodingKey {
        case subCategoryID = "subCategoryId"
        case subCategoryName
    }
}

// MARK: - Hashtag
struct BookHashtag: Codable {
    let hashTagID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case hashTagID = "hashTagId"
        case name
    }
}

struct BookRecordResponseDTO: Codable {
    let totalCount: Int
    let reviews: [BookRecordList]
}

// MARK: - Review
struct BookRecordList: Codable {
    let reviewID: Int
    let coverURL: String
    let title: String
    let readPeriod: Int
    let readStartDate, readEndDate: String
    let reviewTagIcon: String
    let reviewTagColor: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case coverURL = "coverUrl"
        case title, readPeriod, readStartDate, readEndDate, reviewTagIcon, reviewTagColor
    }
}

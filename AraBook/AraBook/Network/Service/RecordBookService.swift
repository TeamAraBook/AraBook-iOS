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
    
    case postReviews(dto: RecordBookRequestDTO)
}

extension RecordBookTarget: BaseTargetType {
    
    var path: String {
        return URLConstant.reviews
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .postReviews(let dto):
            return .requestJSONEncodable(dto)
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

//
//  RecordTarget.swift
//  AraBook
//
//  Created by 고아라 on 10/16/24.
//

import Moya

enum RecordTarget {
    
    case getBookDetail(bookId: Int)
    case postReviews(dto: RecordBookRequestDTO)
    case getRecordBookList
    case getRecordBookDetail(reviewId: Int)
}

extension RecordTarget: BaseTargetType {
    
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
        case .getRecordBookDetail(let reviewId):
            let path = URLConstant.reviewsDetail
                .replacingOccurrences(of: "{reviewId}", with: String(reviewId))
            return path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReviews:
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postReviews(let dto):
            return .requestJSONEncodable(dto)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.hasTokenHeader
    }
}

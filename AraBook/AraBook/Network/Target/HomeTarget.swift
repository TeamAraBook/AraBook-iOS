//
//  HomeTarget.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

import Foundation

import Moya

enum HomeTarget {
    
    case getRecommendAi
    case getRecommendBestSeller
    case getBookSearch(keyword: String)
}

extension HomeTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getRecommendAi:
            return URLConstant.recommendAiURL
        case .getRecommendBestSeller:
            return URLConstant.recommendBestSellerURL
        case .getBookSearch:
            return URLConstant.bookSearchURL
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getBookSearch(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword],
                                      encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.hasTokenHeader
    }
}

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
}

extension HomeTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getRecommendAi:
            return URLConstant.recommendAiURL
        case .getRecommendBestSeller:
            return URLConstant.recommendBestSellerURL
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return HeaderConstant.hasTokenHeader
    }
}

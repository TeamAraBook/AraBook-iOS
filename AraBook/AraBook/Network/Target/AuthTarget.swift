//
//  AuthTarget.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import Foundation

import Moya

enum AuthTarget {
    
    case postAuthLogin(dto: LoginRequestDto)
}

extension AuthTarget: BaseTargetType {
    
    var path: String {
        return URLConstant.authSocialLoginURL
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .postAuthLogin(let dto):
            return .requestJSONEncodable(dto)
        }
    }
    
    var headers: [String : String]? {
        return HeaderConstant.noTokenHeader
    }
}

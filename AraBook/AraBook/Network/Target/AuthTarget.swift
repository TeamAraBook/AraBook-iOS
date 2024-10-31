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
    case delWithdraw
}

extension AuthTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .postAuthLogin:
            return URLConstant.authSocialLoginURL
        case .delWithdraw:
            return URLConstant.withdrawURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAuthLogin:
            return .post
        case .delWithdraw:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postAuthLogin(let dto):
            return .requestJSONEncodable(dto)
        case .delWithdraw:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postAuthLogin:
            return HeaderConstant.noTokenHeader
        case .delWithdraw:
            return HeaderConstant.hasTokenHeader
        }
    }
}

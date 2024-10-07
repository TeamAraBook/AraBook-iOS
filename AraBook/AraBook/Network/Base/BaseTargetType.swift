//
//  BaseTargetType.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
}


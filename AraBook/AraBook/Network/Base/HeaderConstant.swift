//
//  HeaderConstant.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

import Foundation

enum NetworkHeaderKey: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum HeaderConstant {
    
    //MARK: - Header

    static var noTokenHeader: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: "application/json"
        ]
    }
    
    static var hasTokenHeader: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: "application/json",
            NetworkHeaderKey.authorization.rawValue: "Bearer \(UserManager.shared.getAccessToken)"
        ]
    }
}

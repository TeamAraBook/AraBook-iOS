//
//  URLConstant.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

import Foundation

enum URLConstant {
    
    // MARK: - Base URL
    
    static let baseURL = Config.baseURL
    
    // auth
    
    static let authSocialLoginURL = "/auth/social-login"
    
    // home
    
    static let recommendAiURL = "/recommend/ai"
    static let recommendBestSellerURL = "/recommend/best-seller"
    static let bookSearchURL = "/books/search"
}

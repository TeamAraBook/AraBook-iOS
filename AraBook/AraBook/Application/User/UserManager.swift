//
//  UserManager.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "accessToken") private(set) var accessToken
    @UserDefaultWrapper<String>(key: "refreshToken") private(set) var refreshToken
    @UserDefaultWrapper<Bool>(key: "doOnboarding") private(set) var doOnboarding
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getRefreshToken: String { return self.refreshToken ?? "" }
    var hasOnboarding: Bool { return self.doOnboarding != nil }
    
    private init() {}
}

extension UserManager {
    
    func updateToken(_ accessToken: String,
                     _ refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func updateOnboarding() {
        self.doOnboarding = true
    }
    
    func logout() {
        self.accessToken = nil
        self.refreshToken = nil
    }
    
    func withdraw() {
        self.accessToken = nil
        self.refreshToken = nil
        self.doOnboarding = nil
    }
}

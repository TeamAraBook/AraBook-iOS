//
//  AuthService.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import Foundation

import Moya

final class AuthService {
    
    static let shared: AuthService = AuthService()
    
    private let authProvider = MoyaProvider<AuthTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var loginData: GeneralResponse<LoginResponseDto>?
    
    // MARK: - POST
    
    func postLogin(dto: LoginRequestDto,
                   completion: @escaping(GeneralResponse<LoginResponseDto>?) -> Void) {
        authProvider.request(.postAuthLogin(dto: dto)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.loginData = try response.map(GeneralResponse<LoginResponseDto>.self)
                    guard let loginData = self.loginData else { return }
                    completion(loginData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}

//
//  LoginResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

struct LoginResponseDto: Codable {
    let memberID: Int
    let role: String
    let token: Token

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case role, token
    }
}

// MARK: - Token
struct Token: Codable {
    let accessToken, refreshToken: String
}

extension LoginResponseDto {
    
    static func loginResponseInitial() -> LoginResponseDto {
        return LoginResponseDto(memberID: 0, role: "", token: Token(accessToken: "", refreshToken: ""))
    }
}

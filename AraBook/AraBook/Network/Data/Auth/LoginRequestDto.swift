//
//  LoginRequestDto.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

struct LoginRequestDto: Codable {
    let platformType: String
    let socialToken: String
}

//
//  OnboardingService.swift
//  AraBook
//
//  Created by KJ on 10/16/24.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

enum OnboardingTarget {
    
    case getCategoryMain
    case getCategorySub(list: String)
    case putOnboarding(dto: OnboardingRequestDTO)
}

extension OnboardingTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .getCategoryMain:
            return URLConstant.categoryMain
        case .getCategorySub:
            return URLConstant.categorySub
        case .putOnboarding:
            return URLConstant.onboarding
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategoryMain:
            return .get
        case .getCategorySub:
            return .get
        case .putOnboarding:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCategoryMain:
            return .requestPlain
        case .getCategorySub(let list):
            let parameters: [String: Any] = [
                "mainIds": list,
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .putOnboarding(dto: let dto):
            return .requestJSONEncodable(dto)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCategoryMain:
            return HeaderConstant.hasTokenHeader
        case .getCategorySub, .putOnboarding:
            return HeaderConstant.hasTokenHeader
        }
    }
}

struct OnboardingService: Networkable {
    typealias Target = OnboardingTarget
    private static let provider = makeProvider()
    
    static func getCategoryMain() -> Observable<[CategoryMainResponseDTO]> {
        return provider.rx.request(.getCategoryMain)
            .asObservable()
            .mapError()
            .decode(decodeType: [CategoryMainResponseDTO].self)
    }
    
    static func getCategorySub(_ list: String) -> Observable<[CategorySubResponseDTO]> {
        return provider.rx.request(.getCategorySub(list: list))
            .asObservable()
            .mapError()
            .decode(decodeType: [CategorySubResponseDTO].self)
    }
    
    static func putOnboarding(_ dto: OnboardingRequestDTO) -> Observable<EmptyResponse> {
        return provider.rx.request(.putOnboarding(dto: dto))
            .asObservable()
            .mapError()
            .decode(decodeType: EmptyResponse.self)
        
    }
}

struct CategoryMainResponseDTO: Codable {
    let mainCategoryId: Int
    let mainCategoryName: String
}

struct CategorySubResponseDTO: Codable {
    let mainCategoryId: Int
    let mainCategoryName: String
    let subCategories: [SubCategoryLists]
}

struct SubCategoryLists: Codable {
    let subCategoryId: Int
    let subCategoryName: String
}

struct OnboardingRequestDTO: Codable {
    let nickname: String
    let gender: String
    let birthYear: String
    let interestSubCategoryIds: [Int]
}

struct EmptyResponse: Codable {
    let data: String
}

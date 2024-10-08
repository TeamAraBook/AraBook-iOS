//
//  HomeService.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

import Foundation

import Moya

final class HomeService {
    
    static let shared: HomeService = HomeService()
    
    private let homeProvider = MoyaProvider<HomeTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var homeAiData: GeneralResponse<RecommendAiResponseDto>?
    public private(set) var homeBestSellerData: GeneralResponse<RecommendBestSellerResponseDto>?
    public private(set) var bookSearchData: GeneralResponse<SearchBookResponseDto>?
    
    // MARK: - GET
    
    func getHomeAi(completion: @escaping(GeneralResponse<RecommendAiResponseDto>?) -> Void) {
        homeProvider.request(.getRecommendAi) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.homeAiData = try response.map(GeneralResponse<RecommendAiResponseDto>.self)
                    guard let homeAiData = self.homeAiData else { return }
                    completion(homeAiData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getHomeBestSeller(completion: @escaping(GeneralResponse<RecommendBestSellerResponseDto>?) -> Void) {
        homeProvider.request(.getRecommendBestSeller) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.homeBestSellerData = try response.map(GeneralResponse<RecommendBestSellerResponseDto>.self)
                    guard let homeBestSellerData = self.homeBestSellerData else { return }
                    completion(homeBestSellerData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getSearchBook(keyword: String,
                       completion: @escaping(GeneralResponse<SearchBookResponseDto>?) -> Void) {
        homeProvider.request(.getBookSearch(keyword: keyword)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.bookSearchData = try response.map(GeneralResponse<SearchBookResponseDto>.self)
                    guard let bookSearchData = self.bookSearchData else { return }
                    completion(bookSearchData)
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

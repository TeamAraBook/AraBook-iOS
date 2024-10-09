//
//  RecommendBestSellerResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

struct RecommendBestSellerResponseDto: Codable {
    let totalCount: Int
    let books: [BestSellerBook]
}

// MARK: - Book
struct BestSellerBook: Codable {
    let bookID: Int
    let coverURL: String
    let title, author: String

    enum CodingKeys: String, CodingKey {
        case bookID = "bookId"
        case coverURL = "coverUrl"
        case title, author
    }
}

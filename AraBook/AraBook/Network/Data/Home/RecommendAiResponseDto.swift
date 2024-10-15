//
//  RecommendAiResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

struct RecommendAiResponseDto: Codable {
    let bookID: Int
    let coverURL: String
    let title, author: String
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case bookID = "bookId"
        case coverURL = "coverUrl"
        case title, author, categories
    }
}

// MARK: - Category
struct Category: Codable {
    let subCategoryID: Int
    let subCategoryName: String
    
    enum CodingKeys: String, CodingKey {
        case subCategoryID = "subCategoryId"
        case subCategoryName
    }
}

//
//  BookDetailResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/29/24.
//

struct BookDetailResponseDTO: Codable {
    let bookID: Int
    let coverURL: String
    let title, author, publisher, publicationYear: String
    let description: String
    let categories: [BookCategory]
    let hashtags: [BookHashtag]

    enum CodingKeys: String, CodingKey {
        case bookID = "bookId"
        case coverURL = "coverUrl"
        case title, author, publisher, publicationYear, description, categories, hashtags
    }
}

// MARK: - Category
struct BookCategory: Codable {
    let subCategoryID: Int
    let subCategoryName: String

    enum CodingKeys: String, CodingKey {
        case subCategoryID = "subCategoryId"
        case subCategoryName
    }
}

// MARK: - Hashtag
struct BookHashtag: Codable {
    let hashTagID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case hashTagID = "hashTagId"
        case name
    }
}


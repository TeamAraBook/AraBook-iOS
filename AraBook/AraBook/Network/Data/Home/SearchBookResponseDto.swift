//
//  SearchResultResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/9/24.
//

struct SearchBookResponseDto: Codable {
    let totalCount: Int
    let books: [SearchBook]
}

// MARK: - Book
struct SearchBook: Codable {
    let bookID: Int
    let coverURL: String
    let title, author: String

    enum CodingKeys: String, CodingKey {
        case bookID = "bookId"
        case coverURL = "coverUrl"
        case title, author
    }
}

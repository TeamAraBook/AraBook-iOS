//
//  RecordDetailResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/16/24.
//

struct RecordDetailResponseDto: Codable {
    let reviewID, bookID: Int
    let readStartDate, readEndDate: String
    let coverURL: String
    let title, author: String
    let reviewTagIcon: String
    let reviewTagComment, reviewTagColor, content: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case bookID = "bookId"
        case readStartDate, readEndDate
        case coverURL = "coverUrl"
        case title, author, reviewTagIcon, reviewTagComment, reviewTagColor, content
    }
}

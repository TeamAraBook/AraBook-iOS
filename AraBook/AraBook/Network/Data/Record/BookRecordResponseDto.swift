//
//  BookRecordResponseDto.swift
//  AraBook
//
//  Created by 고아라 on 10/29/24.
//

struct BookRecordResponseDTO: Codable {
    let totalCount: Int
    let reviews: [BookRecordList]
}

// MARK: - Review
struct BookRecordList: Codable {
    let reviewID: Int
    let coverURL: String
    let title: String
    let readPeriod: Int
    let readStartDate, readEndDate: String
    let reviewTagIcon: String
    let reviewTagColor: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case coverURL = "coverUrl"
        case title, readPeriod, readStartDate, readEndDate, reviewTagIcon, reviewTagColor
    }
}

//
//  ModifyRecordBookRequestDto.swift
//  AraBook
//
//  Created by KJ on 11/4/24.
//

struct ModifyRecordBookRequestDto: Codable {
    let reviewID: Int
    let reviewTag, content, readStartDate, readEndDate: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case reviewTag, content, readStartDate, readEndDate
    }
}

//
//  RecordBookRequestDto.swift
//  AraBook
//
//  Created by 고아라 on 10/29/24.
//

struct RecordBookRequestDTO: Codable {
    let bookId: Int
    let reviewTag: String
    let content: String
    let readStartDate: String
    let readEndDate: String
}

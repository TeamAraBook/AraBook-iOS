//
//  RecordListModel.swift
//  AraBook
//
//  Created by KJ on 9/27/24.
//

import Foundation

struct RecordListModel {
    let id: Int
    let title: String
    let totalReadDate: String
    let readDate: String
}

extension RecordListModel {
    
    static func dummy() -> [RecordListModel] {
        return [
            RecordListModel(id: 0,
                                   title: "퀸의 대각선",
                                   totalReadDate : "총 7일 동안 읽었어요!",
                                   readDate: "23. 11. 25 ~ 24. 09. 20"
            ),
            RecordListModel(id: 2,
                                   title: "퀸의 대각선",
                                   totalReadDate : "총 7일 동안 읽었어요!",
                                   readDate: "23. 11. 25 ~ 24. 09. 20"
            ),
            RecordListModel(id: 3,
                                   title: "퀸의 대각선",
                                   totalReadDate : "총 7일 동안 읽었어요!",
                                   readDate: "23. 11. 25 ~ 24. 09. 20"
            )
        ]
    }
}

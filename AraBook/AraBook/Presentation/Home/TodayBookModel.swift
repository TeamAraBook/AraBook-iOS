//
//  TodayBookModel.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import Foundation

struct TodayBookModel {
    let id: Int
    let title: String
    let author: String
    let page: Int
}

extension TodayBookModel {
    
    static func dummy() -> TodayBookModel {
        return TodayBookModel(id: 0,
                              title: "퀸의 대각선",
                              author: "베르나르 베르베르",
                              page: 98)
    }
}

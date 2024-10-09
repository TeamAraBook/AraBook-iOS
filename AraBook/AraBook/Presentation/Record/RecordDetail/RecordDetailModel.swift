//
//  RecordDetailModel.swift
//  AraBook
//
//  Created by 고아라 on 10/1/24.
//

import Foundation

struct RecordDetailModel {
    let id: Int
    let title: String
    let author: String
    let ment: String
    let content: String
}

struct RecordFrontModel {
    let id: Int
    let title: String
    let author: String
}

struct RecordBackModel {
    let id: Int
    let ment: String
    let content: String
}

extension RecordDetailModel {
    
    static func dummy() -> RecordDetailModel {
        return RecordDetailModel(id: 0,
                                 title:"퀸의 대각선",
                                 author: "베르나르베르베르",
                                 ment: "조금 아쉬웠어~..",
                                 content: "베르나르는 굿이에여.\n구우우우웃")
    }
}

extension RecordFrontModel {
    
    static func dummy() -> RecordFrontModel {
        return RecordFrontModel(id: 0,
                                title: "퀸의 대각선",
                                author: "베르나르베르베르")
    }
}

extension RecordBackModel {
    
    static func dummy() -> RecordBackModel {
        return RecordBackModel(id: 0,
                               ment: "조금 아쉬웠어~..",
                               content: "베르나르는 굿이에여.\n구우우우웃")
    }
}

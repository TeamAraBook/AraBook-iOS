//
//  BestSellerModel.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import Foundation

struct BestSellerModel {
    let id: Int
    let title: String
    let author: String
}

extension BestSellerModel {
    
    static func dummy() -> [BestSellerModel] {
        return [
            BestSellerModel(id: 1, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 2, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 3, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 4, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 5, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 6, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 7, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 8, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 9, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 10, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 11, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 12, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 13, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 14, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 15, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 16, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 17, title: "퀸의 대각선",author: "베르나르 베르베르"),
            BestSellerModel(id: 18, title: "퀸의 대각선",author: "베르나르 베르베르")
        ]
    }
}

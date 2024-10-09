//
//  GeneralResponse.swift
//  AraBook
//
//  Created by 고아라 on 10/7/24.
//

import Foundation

struct GeneralResponse<T: Decodable>: Decodable {
    var code: Int
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(Int.self, forKey: .code)) ?? 0
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}

//
//  NSObject+.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

//
//  ViewModel.swift
//  AraBook
//
//  Created by 고아라 on 9/27/24.
//

import UIKit

protocol ViewModel where Self: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

//
//  RecordService.swift
//  AraBook
//
//  Created by 고아라 on 10/29/24.
//

import Foundation

import Moya

final class RecordService {
    
    static let shared: RecordService = RecordService()
    
    private let recordProvider = MoyaProvider<RecordTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var delRecordData: GeneralResponse<EmptyDataResponse>?
    
    // MARK: - DELETE
    
    func delRecordData(reviewId: Int,
                       completion: @escaping(GeneralResponse<EmptyDataResponse>?) -> Void) {
        recordProvider.request(.delRecordBookDeatil(reviewId: reviewId)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.delRecordData = try response.map(GeneralResponse<EmptyDataResponse>.self)
                    guard let delRecordData = self.delRecordData else { return }
                    completion(delRecordData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}

//
//  ObservableType+.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import Foundation

import Moya
import RxSwift

extension Observable where Element == Response {
    
    /**
     Response 타입을 리턴하는 Observable 로써, statusCode 에 따라 구분합니다.
     */
    func mapError() -> Observable<Response> {
        flatMap { element -> Observable<Response> in
            .create { observer in
                switch element.statusCode {
                case 200...299:
                    observer.onNext(element)
                case 300...399:
                    print("👉🏻 Redirecting is Possible.")
                    observer.onNext(element)
                case 400:
                    observer.onError(ServiceError.invalidResponse(responseCode: element.statusCode, message: element.description))
                case 401:
                    observer.onError(ServiceError.tokenExpired)
                case 403...499:
                    observer.onError(ServiceError.invalidResponse(responseCode: element.statusCode, message: element.description))
                    print("❗️ Error Occurred.")
                default:
                    break
                }
                return Disposables.create()
            }
        }
    }
    
    /**
     해당 타입을 명시하여, 해당 타입으로 디코딩합니다.
     */
    func decode<Result: Codable>(decodeType: Result.Type) -> Observable<Result> {
        flatMap { element -> Observable<Result> in
            .create { observer in
                do {
                    guard let decoded = try JSONDecoder().decode(GeneralResponse<Result>.self, from: element.data).data else { return Disposables.create() }
                    observer.onNext(decoded)
                } catch let error {
                    print("❗️ Decoding Error")
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
    }

}

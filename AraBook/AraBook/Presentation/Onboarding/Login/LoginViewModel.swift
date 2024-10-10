//
//  LoginViewModel.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    private let authService: AuthService
    
    init(authService: AuthService = AuthService.shared) {
        self.authService = authService
    }
    
    struct Input {
        let kakaoButtonTapped: PublishRelay<LoginRequestDto>
    }
    
    struct Output {
        let loginData = PublishRelay<LoginResponseDto>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.kakaoButtonTapped
            .subscribe(with: self, onNext: { owner, requestDto in
                owner.bindOutput(output: output,
                                 dto: requestDto,
                                 disposeBag: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension LoginViewModel {
    
    private func bindOutput(output: Output, dto: LoginRequestDto, disposeBag: DisposeBag) {
        authService.postLogin(dto: dto) { response in
            guard let data = response?.data else { return }
            output.loginData.accept(data)
        }
    }
}

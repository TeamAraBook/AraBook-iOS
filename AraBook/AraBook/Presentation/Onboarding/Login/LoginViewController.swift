//
//  LoginViewController.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    private let kakaoButtonTapped = PublishRelay<LoginRequestDto>()
    
    // MARK: - UI Properties
    
    private let backImageView = UIImageView(image: .imgBackground)
    private let logoImageView = UIImageView(image: .imgLogo)
    
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아라북"
        label.textColor = .black
        label.font = .araFont(type: .PyeongChangBold, size: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let kakaoButton = {
        let button = UIButton()
        button.setImage(.btnKakao, for: .normal)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        bindViewModel()
    }
}

extension LoginViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        kakaoButton.rx.tap
            .subscribe(onNext: { _ in
                self.checkHasKakaoApp()
            })
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        view.addSubviews(backImageView,
                        logoImageView,
                        loginTitleLabel,
                        kakaoButton)
    }
    
    func setLayout() {
        backImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(230)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(180)
        }
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(56)
        }
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(
            kakaoButtonTapped: kakaoButtonTapped
        )
        
        let output = loginViewModel.transform(input: input)
        
        output.loginData
            .asDriver(onErrorJustReturn: LoginResponseDto.loginResponseInitial())
            .drive(with: self, onNext: { owner, loginData in
                UserManager.shared.updateToken(loginData.token.accessToken,
                                               loginData.token.refreshToken)
                let nav = FirstOnboardingViewController()
                self.navigationController?.pushViewController(nav, animated: false)
            })
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    
    func checkHasKakaoApp() {
        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoAppLogin()
        } else {
            kakaoLogin()
        }
    }
    
    func kakaoLogin() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if error != nil {
                self.showKakaoLoginFailMessage()
            } else if let socialToken = oauthToken?.accessToken {
                self.kakaoButtonTapped.accept(LoginRequestDto(platformType: "KAKAO",
                                                              socialToken: socialToken))
            }
        }
    }
    
    func kakaoAppLogin() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if error != nil {
                self.showKakaoLoginFailMessage()
            } else if let socialToken = oauthToken?.accessToken {
                self.kakaoButtonTapped.accept(LoginRequestDto(platformType: "KAKAO",
                                                              socialToken: socialToken))
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        print("카카오 로그인 실패")
    }
}

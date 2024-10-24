//
//  FirstOnboardingViewController.swift
//  AraBook
//
//  Created by KJ on 10/15/24.
//

import UIKit

import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift

final class FirstOnboardingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let firstView = FirstOnboardingView()
    
    // MARK: - Properties
    
    private let onboardingVM = OnboardingViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        bindGender()
        bindViewModel()
        bindButtonActive()
        setTapScreen()
    }
}

extension FirstOnboardingViewController {
    
    private func bindGender() {
        
        firstView.manButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onboardingVM.inputs.genderButtonTapped(.man)
            })
            .disposed(by: disposeBag)
        
        firstView.womanButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onboardingVM.inputs.genderButtonTapped(.woman)
            })
            .disposed(by: disposeBag)
        
        firstView.unSelectGenderButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onboardingVM.inputs.genderButtonTapped(.none)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindButtonActive() {
        
        firstView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                let model: OnboardingUserInfo = OnboardingUserInfo(
                    nickname: firstView.nicknameTextField.text ?? "",
                    birth: firstView.birthYearTextField.text ?? "",
                    gender: firstView.selectedGender)
                onboardingVM.inputs.userInfo(model)
                self.navigationController?.pushViewController(SecondOnboardingViewController(viewModel: onboardingVM), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        
        onboardingVM.outputs.selectedGenderType
            .subscribe(onNext: { [weak self] type in
                self?.firstView.selectedGenderButton(type)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubview(firstView)
        
        firstView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Methods
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
            tapGestureRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        gesture.location(in: self.view)
        self.view.endEditing(true)
    }
}

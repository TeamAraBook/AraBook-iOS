//
//  RecordBookViewController.swift
//  AraBook
//
//  Created by KJ on 10/11/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class RecordBookViewController: UIViewController {
    
    // MARK: - UI Components

    private let recordBookView = RecordBookView()
    private let scrollView = UIScrollView()
    
    // MARK: - Properties
    
    private let recordBookVM = RecordBookViewModel()
    private let viewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    private let selectedCharacter =
    BehaviorRelay<CharacterType>(value: .notMuch)
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewWillAppear.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
        bindCharacterButton()
    }
}

extension RecordBookViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindCharacterButton() {
        recordBookView.characterView.notMuchButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.selectedCharacter.accept(.notMuch)
            })
            .disposed(by: disposeBag)
        
        recordBookView.characterView.littleBitButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.selectedCharacter.accept(.littleBit)
            })
            .disposed(by: disposeBag)
        
        recordBookView.characterView.normalButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.selectedCharacter.accept(.normal)
            })
            .disposed(by: disposeBag)
        
        recordBookView.characterView.funButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.selectedCharacter.accept(.fun)
            })
            .disposed(by: disposeBag)
        
        recordBookView.characterView.lifeBookButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.selectedCharacter.accept(.lifeBook)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = RecordBookViewModel.Input(
            characterButtonTapped: selectedCharacter
        )
        
        let output = recordBookVM.transform(input: input)
        
        output.selectedCharacter
            .subscribe(onNext: { [weak self] character in
                guard let self else { return }
                recordBookView.characterView.updateButtonSelection(character)
            })
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        
        self.view.addSubviews(recordBookView)
        
    }
    
    func setLayout() {
        
        recordBookView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

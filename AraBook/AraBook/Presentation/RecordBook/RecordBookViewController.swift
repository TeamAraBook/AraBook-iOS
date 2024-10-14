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
    private let datePicker = UIDatePicker()

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
        bindViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
        bindCharacterButton()
        bindDate()
        setDelegate()
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
    
    func bindDate() {

        recordBookView.recordDateView.startDate.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.recordBookView.recordDateView.startDate.selectedCalendar()
                self.presentToHalfModalViewController(.start)
                
            })
            .disposed(by: disposeBag)
        
        recordBookView.recordDateView.endDate.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.recordBookView.recordDateView.endDate.selectedCalendar()
                self.presentToHalfModalViewController(.end)
                
            })
            .disposed(by: disposeBag)
    }

    
    func bindViewModel() {
        let input = RecordBookViewModel.Input(
            characterButtonTapped: selectedCharacter,
            startDate: BehaviorRelay(value: ""),
            endDate: BehaviorRelay(value: "")
        )
        
        let output = recordBookVM.transform(input: input)
        
        output.selectedCharacter
            .subscribe(onNext: { [weak self] character in
                guard let self else { return }
                recordBookView.characterView.updateButtonSelection(character)
                print(character)
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
    
    func setDelegate() {
        recordBookVM.delegate = self
    }
}

extension RecordBookViewController {
    
    // MARK: - Methods
    
    private func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
    }
    
    private func presentToHalfModalViewController(_ type: DatePickerType) {
        
        let datePickVC = DatePickerViewController(viewModel: recordBookVM, type: type)
        datePickVC.modalPresentationStyle = .pageSheet
        let customDetentIdentifier = UISheetPresentationController.Detent.Identifier("DatePickerModal")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentIdentifier) { (_) in
            return SizeLiterals.Screen.screenHeight * 330 / 812
        }
        
        if let sheet = datePickVC.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.preferredCornerRadius = 15
            sheet.prefersGrabberVisible = true
            sheet.delegate = datePickVC as? any UISheetPresentationControllerDelegate
        }
        
//        caveListVC.indexPath = self.indexPath
        present(datePickVC, animated: true)
    }
}

extension RecordBookViewController: RecordBookViewModelDelegate {
    
    func didUpdateStartDate(_ date: String) {
        recordBookView.recordDateView.bindStartDate(date)
    }
    
    func didUpdateEndDate(_ date: String) {
        recordBookView.recordDateView.bindEndDate(date)
    }
}

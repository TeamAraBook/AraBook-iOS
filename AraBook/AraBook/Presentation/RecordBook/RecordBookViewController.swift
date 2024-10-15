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
    private let datePicker = UIDatePicker()

    // MARK: - Properties
    
    private let recordBookVM = RecordBookViewModel()
    private let viewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    private let selectedCharacter =
    BehaviorRelay<CharacterType>(value: .notMuch)
    private let startDate = PublishRelay<String>()
    private let endDate = PublishRelay<String>()
    private let textViewPlaceholder: String = "책에 대한 간단한 소감을 적어주세요."
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
        bindCharacterButton()
        bindDate()
        setDelegate()
        setTapScreen()
        registerForKeyboardNotifications()
        bindTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
        self.viewWillAppear.accept(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    deinit {
        unregisterFromKeyboardNotifications()
    }
}

extension RecordBookViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        recordBookView.do {
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
        }
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
    
    private func bindTextView() {
        // textViewDidBeginEditing
        recordBookView.bookReviewView.reviewTextView.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.recordBookView.bookReviewView.reviewTextView.text = nil
                self.recordBookView.bookReviewView.reviewTextView.textColor = .black
                self.recordBookView.bookReviewView.reviewTextView.layer.borderWidth = 1
                self.recordBookView.bookReviewView.reviewTextView.layer.borderColor = UIColor.chGreen.cgColor
            })
            .disposed(by: disposeBag)

        // textViewDidEndEditing
        recordBookView.bookReviewView.reviewTextView.rx.didEndEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.recordBookView.bookReviewView.reviewTextView.layer.borderWidth = 0

                if self.recordBookView.bookReviewView.reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.recordBookView.bookReviewView.reviewTextView.text = self.textViewPlaceholder
                    self.recordBookView.bookReviewView.reviewTextView.textColor = UIColor.gray900
                    self.recordBookView.bookReviewView.reviewTextView.layer.borderWidth = 0
                }
//                self.validateFields()
            })
            .disposed(by: disposeBag)

        // textViewDidChange
        recordBookView.bookReviewView.reviewTextView.rx.text
            .orEmpty // Ensure it's always a non-optional String
            .subscribe(onNext: { [weak self] _ in
//                self?.validateFields()
            })
            .disposed(by: disposeBag)
    }

    
    func bindViewModel() {
        let input = RecordBookViewModel.Input(
            characterButtonTapped: selectedCharacter,
            startDate: PublishRelay(),
            endDate: PublishRelay()
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
            $0.top.width.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func setDelegate() {
        recordBookVM.delegate = self
//        recordBookView.bookReviewView.reviewTextView.delegate = self
    }
}

extension RecordBookViewController {
    
    // MARK: - Methods
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
    }
    
    private func presentToHalfModalViewController(_ type: DatePickerType) {
        
        let datePickVC = DatePickerViewController(viewModel: recordBookVM, type: type, start: startDate, end: endDate)
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
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
            tapGestureRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        gesture.location(in: self.view)
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        recordBookView.contentInset = contentInsets
        recordBookView.scrollIndicatorInsets = contentInsets
        
        let activeField = recordBookView.bookReviewView.reviewTextView
        var rect = activeField.convert(activeField.bounds, to: recordBookView)
        recordBookView.scrollRectToVisible(rect, animated: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        recordBookView.contentInset = contentInsets
        recordBookView.scrollIndicatorInsets = contentInsets
    }
}

extension RecordBookViewController: RecordBookViewModelDelegate {
    
    func didUpdateStartDate(_ date: String) {
        recordBookView.recordDateView.bindStartDate(date)
        recordBookView.recordDateView.startDate.unSelectedCalendar()
    }
    
    func didUpdateEndDate(_ date: String) {
        recordBookView.recordDateView.bindEndDate(date)
        recordBookView.recordDateView.endDate.unSelectedCalendar()
    }
}

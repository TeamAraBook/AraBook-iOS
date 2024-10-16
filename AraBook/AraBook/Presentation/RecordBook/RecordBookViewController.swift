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
    private let checkButton = PublishRelay<Void>()
    private let postReviews = PublishSubject<RecordBookRequestDTO>()
    
    private var isCharacter: Bool = false
    private var isStart: Bool = false
    private var isEnd: Bool = false
    private let bookId: Int
    
    // MARK: - Initializer

    init(bookId: Int) {
        self.bookId = bookId
        super.init(nibName: nil, bundle: nil)
    }
    
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
        buttonState()
        recordBookButtonTap()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordBookViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        recordBookView.do {
            $0.isScrollEnabled = false
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
        isCharacter = true
        buttonState()
    }
    
    func bindDate() {

        recordBookView.recordDateView.startDate.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.recordBookView.recordDateView.startDate.selectedCalendar()
                self.presentToHalfModalViewController(.start)
                self.isStart = true
            })
            .disposed(by: disposeBag)
        
        recordBookView.recordDateView.endDate.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.recordBookView.recordDateView.endDate.selectedCalendar()
                self.presentToHalfModalViewController(.end)
                self.isEnd = true
            })
            .disposed(by: disposeBag)
        buttonState()
    }
    
    private func bindTextView() {
        recordBookView.bookReviewView.reviewTextView.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.recordBookView.bookReviewView.reviewTextView.text = nil
                self.recordBookView.bookReviewView.reviewTextView.textColor = .black
                self.recordBookView.bookReviewView.reviewTextView.layer.borderWidth = 1
                self.recordBookView.bookReviewView.reviewTextView.layer.borderColor = UIColor.chGreen.cgColor
            })
            .disposed(by: disposeBag)

        recordBookView.bookReviewView.reviewTextView.rx.didEndEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.recordBookView.bookReviewView.reviewTextView.layer.borderWidth = 0

                if self.recordBookView.bookReviewView.reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.recordBookView.bookReviewView.reviewTextView.text = self.textViewPlaceholder
                    self.recordBookView.bookReviewView.reviewTextView.textColor = UIColor.gray900
                    self.recordBookView.bookReviewView.reviewTextView.layer.borderWidth = 0
                }
                self.buttonState()
            })
            .disposed(by: disposeBag)
    }

    private func recordBookButtonTap() {
        recordBookView.submitButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                let text = recordBookView.bookReviewView.reviewTextView.text ?? ""
                let start = convertDateFormat(recordBookView.recordDateView.startDate.dateLabel.text ?? "")
                let end = convertDateFormat(recordBookView.recordDateView.endDate.dateLabel.text ?? "")
                var tag: String
                switch selectedCharacter.value {
                case .notMuch:
                    tag = "DISAPPOINTED"
                case .littleBit:
                    tag = "SLIGHTLY_DISAPPOINTED"
                case .normal:
                    tag = "AVERAGE"
                case .fun:
                    tag = "ENJOYABLE"
                case .lifeBook:
                    tag = "LIFE_CHANGING"
                case .none:
                    tag = ""
                }
                
                self.postReviews.onNext(RecordBookRequestDTO(bookId: self.bookId, reviewTag: tag, content: text, readStartDate: start, readEndDate: end))
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = RecordBookViewModel.Input(
            characterButtonTapped: selectedCharacter,
            startDate: PublishRelay<String>(),
            endDate: PublishRelay<String>(),
            reviewText: recordBookView.bookReviewView.reviewTextView.rx.text.orEmpty.asObservable(),
            checkButton: checkButton,
            postReviews: postReviews
        )
        
        let output = recordBookVM.transform(input: input)
        
        output.selectedCharacter
            .subscribe(onNext: { character in
                self.recordBookView.characterView.updateButtonSelection(character)
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
    
    private func buttonState() {
        let isText = recordBookView.bookReviewView.reviewTextView.text != textViewPlaceholder && !recordBookView.bookReviewView.reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        if isText && isCharacter && isStart && isEnd {
            recordBookView.submitButton.setState(.allow)
        } else {
            recordBookView.submitButton.setState(.notAllow)
        }
    }
    
    func convertDateFormat(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let dateObject = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: dateObject)
        } else {
            return "Invalid Date"
        }
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

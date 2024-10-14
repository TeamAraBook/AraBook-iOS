//
//  DatePickerViewController.swift
//  AraBook
//
//  Created by KJ on 10/12/24.
//

import UIKit

import Moya
import SnapKit
import Then
import RxSwift
import RxCocoa

enum DatePickerType {
    case start
    case end
}

final class DatePickerViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let datePicker = UIDatePicker()
    private let checkButton = UIButton()
    
    // MARK: - Properties
    
    private var recordBookVM: RecordBookViewModel
    private let disposeBag = DisposeBag()
    private var dateType: DatePickerType
    private let startDate: PublishRelay<String>
    private let endDate: PublishRelay<String>
    
    // MARK: - Initializer

    init(viewModel: RecordBookViewModel, type: DatePickerType, start: PublishRelay<String>, end: PublishRelay<String>){
        self.recordBookVM = viewModel
        self.dateType = type
        self.startDate = start
        self.endDate = end
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        bindPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DatePickerViewController {
    
    private func bindPicker() {
        
        let input = RecordBookViewModel.Input(
            characterButtonTapped: BehaviorRelay(value: .notMuch),
            startDate: startDate,
            endDate: endDate)
        
        let output = recordBookVM.transform(input: input)
        
        checkButton.rx.tap
            .subscribe(onNext: { [weak self] in
                if let date = self?.datePicker.date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                    let selectedDate = formatter.string(from: date)
                    switch self?.dateType {
                    case .start:
                        self?.startDate.accept(selectedDate)
                    case .end:
                        self?.endDate.accept(selectedDate)
                    case .none:
                        self?.startDate.accept("none")
                    }
                }
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        
        datePicker.do {
            $0.datePickerMode = .date
            $0.preferredDatePickerStyle = .wheels
            $0.locale = Locale(identifier: "ko_KR")
        }
        
        checkButton.do {
            $0.setTitle("입력", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .araFont(type: .PretandardBold, size: 20)
            $0.backgroundColor = .chGreen
            $0.makeCornerRound(radius: 16)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubviews(checkButton, datePicker)
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        datePicker.snp.makeConstraints {
            $0.bottom.equalTo(checkButton.snp.top).offset(-30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods

}

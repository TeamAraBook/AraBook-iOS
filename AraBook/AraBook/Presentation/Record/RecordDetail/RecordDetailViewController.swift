//
//  RecordDetailViewController.swift
//  AraBook
//
//  Created by 고아라 on 10/1/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class RecordDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let recordVM: RecordListViewModel
    private let detailViewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    private var bookID: Int = 0
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let navi = CustomNavigationBar()
        navi.isTitleLabelIncluded = "나의 독서 기록"
        navi.isTitleViewIncluded = true
        navi.isBackButtonIncluded = true
        navi.isEditButtonIncluded = true
        return navi
    }()
    
    private lazy var frontCardView = RecordDetailFrontView()
    private lazy var backCardView = RecordDetailBackView()
    
    private let touchTitle = {
        let label = UILabel()
        label.text = "카드를 터치해주세요!"
        label.textColor = .gray400
        label.font = .araFont(type: .PretandardBold, size: 20)
        return label
    }()
    
    // MARK: - LifeCycle
    
    init(viewModel: RecordListViewModel) {
        self.recordVM = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailViewWillAppear.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setHierarchy()
        setLayout()
        setGesture()
    }
}

extension RecordDetailViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.isUserInteractionEnabled = true
        backCardView.isHidden = true
        
        navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationBar.editButtonAction = {
            let nav = RecordBookViewController(bookId: self.bookID)
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    
    func bindViewModel() {
        let input = RecordListViewModel.Input(
            viewWillAppear: PublishRelay(),
            selectRecordList: PublishRelay(),
            detailViewWillAppear: detailViewWillAppear
        )
        
        let output = recordVM.transform(input: input)
        
        output.recordDetailData
            .subscribe(onNext: { data in
                self.bookID = data.bookID
                self.frontCardView.bindFrontView(model: data)
                self.backCardView.bindBackView(model: data)
            })
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar,
                         frontCardView,
                         backCardView,
                         touchTitle)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        frontCardView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        backCardView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        touchTitle.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
    
    func frontToBack() {
        self.backCardView.isHidden.toggle()
        UIView.transition(with: self.backCardView, duration: 0.6, options: .transitionFlipFromRight, animations: nil)
        
        UIView.transition(with: self.frontCardView, duration: 0.6, options: .transitionFlipFromRight, animations: nil, completion: {_ in
            self.frontCardView.isHidden.toggle()
        })
    }
    
    func backToFront() {
        self.frontCardView.isHidden.toggle()
        UIView.transition(with: self.frontCardView, duration: 0.6, options: .transitionFlipFromRight, animations: nil)
        UIView.transition(with: self.backCardView, duration: 0.6, options: .transitionFlipFromRight, animations: nil, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.backCardView.isHidden.toggle()
        }
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        if backCardView.isHidden {
            frontToBack()
        } else {
            backToFront()
        }
    }
}

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
    
    private var frontModel: RecordFrontModel?
    private var backModel: RecordBackModel?
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let navi = CustomNavigationBar()
        navi.isTitleLabelIncluded = "검색하기"
        navi.isTitleViewIncluded = true
        navi.isBackButtonIncluded = true
        return navi
    }()
    
    private lazy var frontCardView = RecordDetailFrontView()
    private lazy var backCardView = RecordDetailBackView()
    
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
    }
    
    func bindViewModel() {
        let input = RecordListViewModel.Input(
            viewWillAppear: PublishRelay(),
            detailViewWillAppear: detailViewWillAppear
        )
        
        let output = recordVM.transform(input: input)
        
        output.recordFrontData
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                frontCardView.bindFrontView(model: data)
            })
            .disposed(by: disposeBag)
        
        output.recordBackData
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                backCardView.bindBackView(model: data)
            })
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar,
                         frontCardView,
                         backCardView)
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

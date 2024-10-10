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
    }
}

extension RecordBookViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindViewModel() {
        let input = RecordBookViewModel.Input(
            viewWillAppear: viewWillAppear
        )
        
        let output = recordBookVM.transform(input: input)
    
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

//
//  RecordEditBSViewController.swift
//  AraBook
//
//  Created by 고아라 on 10/29/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class RecordEditBSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomHeight: CGFloat = 199
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray900.withAlphaComponent(0.7)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        return view
    }()
    
    private let grabberImageView = UIImageView(image: .bottomsheetGrabber)
    
    private let editButton = {
        let button = UIButton()
        button.setImage(.bottomsheetMenuEdit, for: .normal)
        return button
    }()
    
    private let delButton = {
        let button = UIButton()
        button.setImage(.bottomsheetMenuDel, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDismissAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

extension RecordEditBSViewController {
    
    func setUI() {
        view.backgroundColor = .clear
        
        editButton.rx.tap
            .subscribe(onNext: {
                print("editbuttontapped")
            })
            .disposed(by: disposeBag)
        
        delButton.rx.tap
            .subscribe(onNext: {
                print("delbuttontapped")
            })
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        bottomSheet.addSubviews(grabberImageView,
                                editButton,
                                delButton)
        view.addSubviews(backgroundView,
                         bottomSheet)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(bottomHeight)
        }
        
        grabberImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 341)
            $0.height.equalTo(5)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(grabberImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 33)
            $0.height.equalTo(50)
        }
        
        delButton.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 33)
            $0.height.equalTo(50)
        }
    }
    
    func showBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .gray900.withAlphaComponent(0.7)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
}

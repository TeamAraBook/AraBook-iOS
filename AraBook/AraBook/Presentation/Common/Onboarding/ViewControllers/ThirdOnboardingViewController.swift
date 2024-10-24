//
//  ThirdOnboardingViewController.swift
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

final class ThirdOnboardingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let thirdView = ThirdOnboardingView()
    private let nextButton = CheckButton()
    
    // MARK: - Properties
    
    private let onboardingVM: OnboardingViewModel
    private let disposeBag = DisposeBag()
    private var selectedIndexPaths: [IndexPath] = []
    private var subCategory: [Int] = []
    
    // MARK: - Initializer
    
    init(viewModel: OnboardingViewModel) {
        self.onboardingVM = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        self.view = thirdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setRegister()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThirdOnboardingViewController {
    
    private func bindViewModel() {
        
        // MARK: - 지금 애초에 셀 bind가 안됨 데이터는 잘 들어옴 컬렉션뷰의 문제인듯함
        
        onboardingVM.outputs.category1
            .bind(to: thirdView.category1.rx
                .items(cellIdentifier: TopicCollectionViewCell.className,
                       cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
                cell.setCell(model)
            }
                       .disposed(by: disposeBag)
        
        onboardingVM.outputs.category2
            .bind(to: thirdView.category2.rx
                .items(cellIdentifier: TopicCollectionViewCell.className,
                       cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
                cell.setCell(model)
            }
                       .disposed(by: disposeBag)
        
        onboardingVM.outputs.category3
            .bind(to: thirdView.category3.rx
                .items(cellIdentifier: TopicCollectionViewCell.className,
                       cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
                cell.setCell(model)
            }
                       .disposed(by: disposeBag)
        
        onboardingVM.outputs.categorySub
            .subscribe(onNext: { data in
                self.thirdView.bindTitle(data)
            })
            .disposed(by: disposeBag)
        //        // category2 바인딩
        //        onboardingVM.outputs.category2
        //            .bind(to: thirdView.category2.rx
        //                .items(cellIdentifier: TopicCollectionViewCell.className, cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
        //                    cell.setCell(model)
        //                }
        //                .disposed(by: disposeBag)
        //
        //        // category3 바인딩
        //        onboardingVM.outputs.category3
        //            .bind(to: thirdView.category3.rx
        //                .items(cellIdentifier: TopicCollectionViewCell.className, cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
        //                    cell.setCell(model)
        //                }
        //                .disposed(by: disposeBag)
        //
        thirdView.category1.delegate = self
        thirdView.category2.delegate = self
        thirdView.category3.delegate = self
//        thirdView.categoryCollectionView1.dataSource = self
        //
        //        thirdView.category2.rx.setDelegate(self)
        //
        //        thirdView.category3.rx.setDelegate(self)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                print("asdlfija;weoifj;aowe버튼 클릭")
                onboardingVM.inputs.putOnboarding(self.subCategory)
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        nextButton.do {
            $0.setTitle("다음", for: .normal)
            $0.setState(.allow)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubviews(nextButton)
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Methods
    
    private func setRegister() {
        //        thirdView.categoryCollectionView1.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
//        thirdView.category2.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
//        thirdView.category3.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
    }
    
    // MARK: - @objc Methods
}

extension ThirdOnboardingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("dafseijf;aoiejf;oaijwef;🦧🦧🦧🦧🦧🦧🦧🦧", collectionView)
        
        switch collectionView {
        case thirdView.category1:
            let model = onboardingVM.outputs.category1.value[indexPath.item]
            
            let title = model.subCategoryName

            let maxCellWidth = collectionView.bounds.width - 40
            let size = (title as NSString).boundingRect(
                with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
                context: nil
            )

            return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
            
        case thirdView.category2:
            let model = onboardingVM.outputs.category2.value[indexPath.item]
            let title = model.subCategoryName

            let maxCellWidth = collectionView.bounds.width - 40
            let size = (title as NSString).boundingRect(
                with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
                context: nil
            )

            return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
            
        case thirdView.category3:
                let model = onboardingVM.outputs.category3.value[indexPath.item]
                let title = model.subCategoryName
                
                let maxCellWidth = collectionView.bounds.width - 40
                let size = (title as NSString).boundingRect(
                    with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
                    options: .usesLineFragmentOrigin,
                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
                    context: nil
                )
                
                return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

extension ThirdOnboardingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let cell = collectionView.cellForItem(at: indexPath) as? TopicCollectionViewCell {
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.removeAll { $0 == indexPath }
                subCategory.removeAll { $0 == cell.categoryId }
                cell.contentView.backgroundColor = .gray400
                cell.makeCornerRound(radius: cell.contentView.frame.height / 2)
            } else {
                selectedIndexPaths.append(indexPath)
                subCategory.append(cell.categoryId)
                cell.contentView.backgroundColor = .chGreen
                cell.makeCornerRound(radius: cell.contentView.frame.height / 2)
            }
        }
    }
}

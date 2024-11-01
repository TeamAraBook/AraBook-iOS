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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThirdOnboardingViewController {
    
    private func bindViewModel() {
        
        //        onboardingVM.outputs.category1
        //            .bind(to: thirdView.category1.rx
        //                .items(cellIdentifier: TopicCollectionViewCell.className,
        //                       cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
        //                cell.setCell(model)
        //            }
        //                       .disposed(by: disposeBag)
        //
        //        onboardingVM.outputs.category2
        //            .bind(to: thirdView.category2.rx
        //                .items(cellIdentifier: TopicCollectionViewCell.className,
        //                       cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
        //                cell.setCell(model)
        //            }
        //                       .disposed(by: disposeBag)
        //
        //        onboardingVM.outputs.category3
        //            .bind(to: thirdView.category3.rx
        //                .items(cellIdentifier: TopicCollectionViewCell.className,
        //                       cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
        //                cell.setCell(model)
        //            }
        //                       .disposed(by: disposeBag)
        
//        for (index, relay) in onboardingVM.outputs.categoryLists.enumerated() {
//            let collectionView = createCollectionView()
//            thirdView.addSubview(collectionView)
//            thirdView.collectionViews.append(collectionView)
//            print("🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁", index, relay)
//            
//            relay.bind(to: collectionView.rx.items(cellIdentifier: TopicCollectionViewCell.className, cellType: TopicCollectionViewCell.self)) { _, model, cell in
//                print("🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁", model)
//                cell.setCell(model)
//            }
//            .disposed(by: disposeBag)
//            
//            collectionView.snp.makeConstraints {
//                $0.leading.trailing.equalToSuperview()
//                $0.top.equalTo(index == 0 ? thirdView.subCategoryLabel.snp.bottom : thirdView.collectionViews[index - 1].snp.bottom).offset(16)
//                $0.height.equalTo(100)
//            }
//        }
        
        onboardingVM.outputs.categorySub
            .subscribe(onNext: { data in
//                self.thirdView.bindTitle(data)
//                print("🎀🎀🎀🎀🎀🎀🎀🎀", data)
                
                for (index, relay) in self.onboardingVM.outputs.categoryLists.enumerated() {
                    let collectionView = self.createCollectionView()
                    self.thirdView.addSubview(collectionView)
                    self.thirdView.collectionViews.append(collectionView)
                    
                    relay.bind(to: collectionView.rx.items(cellIdentifier: TopicCollectionViewCell.className, cellType: TopicCollectionViewCell.self)) { _, model, cell in
                        print("🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁🛁", model)
                        cell.setCell(model)
                    }
                    .disposed(by: self.disposeBag)
                    
//                    $0.top.equalTo(subCategoryLabel.snp.bottom).offset(30)
                    
                    collectionView.snp.makeConstraints {
                        $0.leading.trailing.equalToSuperview()
                        $0.top.equalTo(index == 0 ? self.thirdView.subCategoryLabel.snp.bottom : self.thirdView.collectionViews[index - 1].snp.bottom).offset(30)
                        $0.height.equalTo(500)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                print("🏮🏮🏮🏮🏮🏮🏮🏮🏮🏮", self.subCategory)
                onboardingVM.inputs.putOnboarding(self.subCategory)
                self.changeRootToTabVC()
            })
            .disposed(by: disposeBag)
        
        onboardingVM.outputs.completeOnboarding
            .subscribe(onNext: { [weak self] in
                self?.changeRootToTabVC()
            })
            .disposed(by: disposeBag)
    }
    
    func changeRootToTabVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let spalshVC = TabBarController()
                let navigationController = UINavigationController(rootViewController: spalshVC)
                window.rootViewController = navigationController
            }
        }
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        nextButton.do {
            $0.setTitle("다음", for: .normal)
            $0.setState(.allow)
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
        }
        
        thirdView.navigationBar.backButtonAction = {
            self.navigationController?.popViewController(animated: true)
            self.onboardingVM.categoryLists.removeAll()
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thirdView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        thirdView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(1700)
        }
        
        view.addSubview(nextButton)  // nextButton을 최상위 뷰에 추가합니다.
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    
    // MARK: - Methods
    
    private func setDelegate() {
//        thirdView.category1.delegate = self
//        thirdView.category2.delegate = self
//        thirdView.category3.delegate = self
        thirdView.collectionViews.forEach { $0.delegate = self }
        
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        return collectionView
    }
}

extension ThirdOnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Similar to your existing implementation for dynamic cell sizing based on text
        let title = onboardingVM.outputs.categoryLists[collectionView.tag].value[indexPath.item].subCategoryName
        print("🧽🧽🧽🧽🧽🧽🧽🧽🧽🧽🧽🧽🧽🧽🧽", title)
        let maxCellWidth = collectionView.bounds.width - 40
        let size = (title as NSString).boundingRect(
            with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )
        return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
    }
}

//extension ThirdOnboardingViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        switch collectionView {
//        case thirdView.category1:
//            let model = onboardingVM.outputs.category1.value[indexPath.item]
//            
//            let title = model.subCategoryName
//
//            let maxCellWidth = collectionView.bounds.width - 40
//            let size = (title as NSString).boundingRect(
//                with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
//                options: .usesLineFragmentOrigin,
//                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
//                context: nil
//            )
//
//            return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
//            
//        case thirdView.category2:
//            let model = onboardingVM.outputs.category2.value[indexPath.item]
//            let title = model.subCategoryName
//
//            let maxCellWidth = collectionView.bounds.width - 40
//            let size = (title as NSString).boundingRect(
//                with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
//                options: .usesLineFragmentOrigin,
//                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
//                context: nil
//            )
//
//            return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
//            
//        case thirdView.category3:
//                let model = onboardingVM.outputs.category3.value[indexPath.item]
//                let title = model.subCategoryName
//                
//                let maxCellWidth = collectionView.bounds.width - 40
//                let size = (title as NSString).boundingRect(
//                    with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
//                    options: .usesLineFragmentOrigin,
//                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
//                    context: nil
//                )
//                
//                return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
//        default:
//            return CGSize(width: 0, height: 0)
//        }
//    }
//}

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
        print(subCategory)
    }
}

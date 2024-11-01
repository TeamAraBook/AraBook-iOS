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
    private var scrollHeight: Int
    
    // MARK: - Initializer
    
    init(viewModel: OnboardingViewModel) {
        self.onboardingVM = viewModel
        self.scrollHeight = viewModel.outputs.categoryLists.count * 70
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for collectionView in self.thirdView.collectionViews {
            self.updateCollectionViewHeight(collectionView)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThirdOnboardingViewController {
    
    private func bindViewModel() {
        
        onboardingVM.outputs.categorySub
            .subscribe(onNext: { data in
                
                for (index, relay) in self.onboardingVM.outputs.categoryLists.enumerated() {
                    let mainTitle = self.createMainTitleLabel()
                    mainTitle.text = "📗 \(data[index].mainCategoryName)"
                    
                    let collectionView = self.createCollectionView()
                    collectionView.tag = index
                    self.thirdView.addSubviews(mainTitle, collectionView)
                    self.thirdView.collectionViews.append(collectionView)
                    
                    var collectionViewHeightConstraint: Constraint?
                    collectionView.snp.makeConstraints {
                        $0.leading.trailing.equalToSuperview().inset(16)
                        $0.top.equalTo(mainTitle.snp.bottom).offset(16)
                        collectionViewHeightConstraint = $0.height.equalTo(50).constraint
                    }
                    
                    relay.bind(to: collectionView.rx.items(cellIdentifier: TopicCollectionViewCell.className, cellType: TopicCollectionViewCell.self)) { _, model, cell in
                        cell.setCell(model)
                    }
                    .disposed(by: self.disposeBag)

                    relay.subscribe(onNext: { _ in
                        DispatchQueue.main.async {
                            self.updateCollectionViewHeight(collectionView)
                        }
                    }).disposed(by: self.disposeBag)
                    
                    mainTitle.snp.makeConstraints {
                        $0.leading.equalToSuperview().inset(16)
                        $0.top.equalTo(index == 0 ? self.thirdView.subCategoryLabel.snp.bottom : self.thirdView.collectionViews[index - 1].snp.bottom).offset(30)
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
            $0.height.equalTo(1500)
        }
        
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    
    // MARK: - Methods
    
    private func setDelegate() {
        thirdView.collectionViews.forEach { $0.delegate = self }
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    private func createMainTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .araFont(type: .PretandardSemiBold, size: 15)
        label.textColor = .gray800
        return label
    }
    
    private func updateCollectionViewHeight(_ collectionView: UICollectionView) {
        collectionView.snp.updateConstraints {
            $0.height.equalTo(collectionView.contentSize.height)
        }
    }
    
    private func setScrollHeight() -> Int {
        let mainCategoryNum = onboardingVM.categoryLists.count
        return mainCategoryNum * 70
    }

}

extension ThirdOnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title: String
        let maxCellWidth = collectionView.bounds.width - 40
        
        if collectionView.tag < onboardingVM.outputs.categoryLists.count {
            title = onboardingVM.outputs.categoryLists[collectionView.tag].value[indexPath.item].subCategoryName
        } else {
            return CGSize(width: 0, height: 0)
        }

        let size = (title as NSString).boundingRect(
            with: CGSize(width: maxCellWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        return CGSize(width: min(maxCellWidth, size.width + 20), height: 36)
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
        print(subCategory)
    }
}

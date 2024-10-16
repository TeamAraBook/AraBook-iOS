//
//  SecondOnboardingViewController.swift
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

final class SecondOnboardingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let secondView = SecondOnboardingView()
    private let nextButton = CheckButton()
    
    // MARK: - Properties
    
    private let onboardingVM: OnboardingViewModel
    private let disposeBag = DisposeBag()
    private var selectedIndexPaths: [IndexPath] = []
    private var mainCategory: [Int] = []
    
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
        bindViewModel()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SecondOnboardingViewController {
    
    private func bindViewModel() {
        
        onboardingVM.outputs.categoryMain
            .bind(to: secondView.secondCollectionView.rx
                .items(cellIdentifier: TopicCollectionViewCell.className, cellType: TopicCollectionViewCell.self)) { (index, model, cell) in
                    cell.configureCell(model)
                    print("🧯🧯🧯🧯🧯🧯🧯", model)
                }
                .disposed(by: disposeBag)
        
        secondView.secondCollectionView.rx.setDelegate(self)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                onboardingVM.inputs.getCategorySub(mainCategory)
                self.navigationController?.pushViewController(ThirdOnboardingViewController(viewModel: onboardingVM), animated: true)
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
        
        self.view.addSubviews(secondView, nextButton)
        
        secondView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Methods
    
    private func setRegister() {
        secondView.secondCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.className)
    }
    
    // MARK: - @objc Methods
}


extension SecondOnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let model = onboardingVM.outputs.categoryMain.value[indexPath.item]
        let title = model.mainCategoryName
        
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

extension SecondOnboardingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TopicCollectionViewCell {
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.removeAll { $0 == indexPath }
                mainCategory.removeAll { $0 == cell.categoryId }
                cell.contentView.backgroundColor = .gray400
                cell.makeCornerRound(radius: cell.contentView.frame.height / 2)
            } else {
                selectedIndexPaths.append(indexPath)
                mainCategory.append(cell.categoryId)
                cell.contentView.backgroundColor = .chGreen
                cell.makeCornerRound(radius: cell.contentView.frame.height / 2)
            }
        }
    }
}

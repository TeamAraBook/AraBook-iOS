//
//  HomeViewController.swift
//  AraBook
//
//  Created by 고아라 on 9/25/24.
//

import UIKit

import SnapKit

final class HomeViewController: UIViewController {
    
    private let todayBookDummy = TodayBookModel.dummy()
    private let bestSellerDummy = BestSellerModel.dummy()
    
    private let todayBookView = HomeTodayBookView()
    
    private let bestSellerTitle = {
        let label = UILabel()
        label.text = "이달의 베스트셀러"
        label.textColor = .black
        label.font = .araFont(type: .PretandardBold, size: 16)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 109, height: 231)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 28
        let cv = UICollectionView(frame: .zero, 
                                  collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: BookCollectionViewCell.className
        )
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        cv.dataSource = self
        return cv
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
    }
}

extension HomeViewController {
    
    func setUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        todayBookView.bindTodayBook(model: todayBookDummy)
    }
    
    func setHierarchy() {
        view.addSubviews(todayBookView,
                         bestSellerTitle,
                         collectionView)
    }
    
    func setLayout() {
        todayBookView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(390)
        }
        
        bestSellerTitle.snp.makeConstraints {
            $0.top.equalTo(todayBookView.snp.bottom).offset(36)
            $0.leading.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bestSellerTitle.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return bestSellerDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.className, for: indexPath) as? BookCollectionViewCell
        else { return UICollectionViewCell() }
        cell.bindBestSeller(model: bestSellerDummy[indexPath.item])
        return cell
    }
}

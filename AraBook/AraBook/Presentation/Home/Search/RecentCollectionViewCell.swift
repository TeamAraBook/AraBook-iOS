//
//  RecentCollectionViewCell.swift
//  AraBook
//
//  Created by 고아라 on 10/8/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

protocol RecentCellDelegate: AnyObject {
    func tapDeleteButtonDelegate(cell: RecentCollectionViewCell)
}

final class RecentCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    var delegate: RecentCellDelegate?
    
    private let recentTitle = UILabel()
    let recentDelButton = UIButton()
    private let recentStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RecentCollectionViewCell {
     
    func setUI() {
        self.backgroundColor = .white
        self.makeCornerRound(radius: 17)
        self.layer.borderColor = UIColor.gray300.cgColor
        self.layer.borderWidth = 1
        
        recentTitle.do {
            $0.textColor = .gray800
            $0.textAlignment = .left
            $0.font = .araFont(type: .PretandardSemiBold, size: 12)
        }
        
        recentDelButton.do {
            $0.setImage(.icClose, for: .normal)
            $0.rx.tap
                .bind { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.tapDeleteButtonDelegate(cell: self)
                }
                .disposed(by: disposeBag)
        }
        
        recentStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
    }
    
    func setHierarchy() {
        addSubview(recentStackView)
        recentStackView.addArrangedSubviews(recentTitle,
                                            recentDelButton)
    }
    
    func setLayout() {
        recentDelButton.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        recentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension RecentCollectionViewCell {
    
    func bindRecentView(title: String) {
        recentTitle.text = title
    }
}

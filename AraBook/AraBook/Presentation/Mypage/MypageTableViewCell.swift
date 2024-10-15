//
//  MypageTableViewCell.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import UIKit

import SnapKit

final class MypageTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .araFont(type: .PretandardRegular, size: 14)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
        setHierarchy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MypageTableViewCell {

    func setUI() {
        backgroundColor = .white
        self.selectionStyle = .none
    }
    
    func setHierarchy() {
        addSubview(titleLabel)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MypageTableViewCell {

    func configureSettingCell(menu: SettingMenu) {
        titleLabel.text = menu.title
    }
}

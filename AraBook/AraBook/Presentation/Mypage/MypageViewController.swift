//
//  MypageViewController.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import SafariServices

final class MypageViewController: UIViewController {
    
    // MARK: - Properties
    
    private let settingSupportMenu = BehaviorSubject<[SettingMenu]>(value: SettingMenu.settingMenuData())
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let navi = CustomNavigationBar()
        navi.isTitleLabelIncluded = "마이페이지"
        navi.isTitleViewIncluded = true
        navi.isBackButtonIncluded = false
        return navi
    }()
    
    private let profileImageView = UIImageView(image: .imgEmpty)
    
    private let profileNameLabel = {
        let label = UILabel()
        label.text = "고아라"
        label.textColor = .black
        label.font = .araFont(type: .PretandardSemiBold, size: 16)
        return label
    }()
    
    private let divideView = {
        let view = UIView()
        view.backgroundColor = .gray500
        return view
    }()
    
    private let settingTableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 52
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        tableView.register(
            MypageTableViewCell.self,
            forCellReuseIdentifier: MypageTableViewCell.className
        )
        return tableView
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setTableView()
    }
}

// MARK: - Extensions

extension MypageViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar, profileImageView, profileNameLabel, divideView, settingTableView)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(profileNameLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(1)
        }
        
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(28)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setTableView() {
        self.settingSupportMenu
            .bind(to: settingTableView.rx
                .items(cellIdentifier: MypageTableViewCell.className,
                       cellType: MypageTableViewCell.self)) { (index, model, cell) in
                cell.configureSettingCell(menu: model)
            }
            .disposed(by: disposeBag)
        
        settingTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                switch indexPath.row {
                case 0:
                    print("개인정보처리방침")
                case 1:
                    print("이용약관")
                case 2:
                    print("개발자소개")
                case 3:
                    UserManager.shared.logout()
                    self.changeRootToSplashVC()
                case 4:
                    UserManager.shared.withdraw()
                    self.changeRootToSplashVC()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func changeRootToSplashVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let spalshVC = SplashViewController()
                let navigationController = UINavigationController(rootViewController: spalshVC)
                window.rootViewController = navigationController
            }
        }
    }
}

//
//  ViewController.swift
//  AraBook
//
//  Created by 고아라 on 9/24/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    let navigationBar = {
        let navi = CustomNavigationBar()
        navi.isBackButtonIncluded = true
        navi.isTitleLabelIncluded = "제목"
        navi.isTitleViewIncluded = true
        navi.isCloseButtonIncluded = true
        return navi
    }()
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .purple
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        navigationBar.backButtonAction = {
            print("tap back button")
        }
        navigationBar.closeButtonAction = {
            print("tap close button")
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

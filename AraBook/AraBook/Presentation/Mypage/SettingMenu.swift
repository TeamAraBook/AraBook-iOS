//
//  SettingMenu.swift
//  AraBook
//
//  Created by 고아라 on 10/10/24.
//

struct SettingMenu {
    let title: String
}

extension SettingMenu {
    
    static func settingMenuData() -> [SettingMenu] {
        return [
            SettingMenu(title: "개인정보처리방침"),
            SettingMenu(title: "이용약관"),
            SettingMenu(title: "개발자 소개"),
            SettingMenu(title: "로그아웃"),
            SettingMenu(title: "탈퇴하기")
        ]
    }
}

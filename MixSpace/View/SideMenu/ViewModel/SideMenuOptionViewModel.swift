//
//  SideMenuViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import Foundation

enum SideMenuOptionViewModel: Int, CaseIterable {
    case profile
    case friend
    case logout
    
    var title: String {
        switch self {
        case .profile: return "내 프로필"
        case .friend: return "친구목록"
        case .logout: return "로그아웃"
        }
    }
    
    var symbolName: String {
        switch self {
        case .profile: return "person.circle"
        case .friend: return "person.2.circle"
        case .logout: return "arrow.backward.circle"
        }
    }
}

//
//  SideMenuViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/18.
//

import Foundation
import Firebase

class SideMenuViewModel: ObservableObject {
    
    func logout() {
        DispatchQueue.global(qos: .background).async {
            try? Auth.auth().signOut()
        }
    }
}

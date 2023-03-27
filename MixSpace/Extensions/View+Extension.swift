//
//  HideKeyboard.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/26.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

//
//  SideMenuOptionView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/18.
//

import SwiftUI

struct SideMenuOptionView: View {
    
    let vm: SideMenuOptionViewModel
    
    var body: some View {
        HStack {
            Image(systemName: vm.symbolName)
                .font(.system(size: 24))
                .foregroundColor(.gray)
            Text(vm.title)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(vm: .profile)
    }
}

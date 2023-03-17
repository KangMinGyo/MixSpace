//
//  SideMenuView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
                Image("Profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                Text("이훈이")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("주먹밥러버")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                UserStatsView()
                    .padding(.vertical)
            }
            .padding(.leading)
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue) { item in
                HStack {
                    Image(systemName: item.symbolName)
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                    Text(item.title)
                        .font(.subheadline)
                    
                    Spacer()
                }
                .frame(height: 40)
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

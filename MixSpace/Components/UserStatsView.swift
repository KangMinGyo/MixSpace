//
//  UserStatsView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack {
            HStack {
                Text("2")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .bold()
                
                Text("Following")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("2")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .bold()
                
                Text("Followers")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}

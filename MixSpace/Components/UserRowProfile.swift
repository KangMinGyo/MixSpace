//
//  User.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct UserRowProfile: View {
    var body: some View {
        HStack(spacing: 12) {
            Image("Profile2")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text("신짱구")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("초코비러버")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        UserRowProfile()
    }
}

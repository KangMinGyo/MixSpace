//
//  User.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct UserRowProfile: View {
    
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            Image("Profile2")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text("\(user.name)")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("@\(user.nickName)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

//struct User_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowProfile()
//    }
//}

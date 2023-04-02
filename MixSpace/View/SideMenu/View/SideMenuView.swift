//
//  SideMenuView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI
import Firebase

struct SideMenuView: View {
    
    @AppStorage("logStatus") var logStatus = true
    @ObservedObject var vm = SideMenuViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
                Image("Profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                Text(vm.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("@\(vm.nickName)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                UserStatsView()
                    .padding(.vertical)
            }
            .padding(.leading)
            
            ForEach(SideMenuOptionViewModel.allCases, id: \.rawValue) { item in
                if item == .profile {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        SideMenuOptionView(vm: item)
                    }
                }  else if item == .logout {
                    Button {
                        DispatchQueue.global(qos: .background).async {
                            try? Auth.auth().signOut()
                        }
                        
                        withAnimation(.easeInOut) {
                            logStatus = false
                        }
                    } label: {
                        SideMenuOptionView(vm: item)
                    }
      
                } else {
                    SideMenuOptionView(vm: item)
                }
            }
            Spacer()
        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView()
//    }
//}

//
//  MainMessageView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/27.
//

import SwiftUI

struct MainMessageView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<10, id: \.self) { num in
                    HStack {
                        Text("User Profile Image")
                        VStack {
                            Text("UserName")
                            Text("Message sent to user")
                        }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                }
            }
            .navigationTitle("Massage")
        }
    }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}

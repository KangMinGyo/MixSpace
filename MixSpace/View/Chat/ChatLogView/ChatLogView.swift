//
//  ChatLogView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/01.
//

import SwiftUI

struct ChatLogView: View {
    let chatUser: ChatUser?
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                Text("Fack Message")
            }
        }.navigationTitle(chatUser?.name ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//struct ChatLogView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatLogView()
//    }
//}

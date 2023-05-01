//
//  NewMessageView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/01.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vm = NewMessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(vm.users) { user in
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: user.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color.gray, lineWidth: 0.5))
                            Text(user.name)
                                .foregroundColor(Color.primary)
                            Spacer()
                        }.padding(.horizontal)
                        Divider()
                    }
                }
            }.navigationTitle("새로운 메시지")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }

                    }
                }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}

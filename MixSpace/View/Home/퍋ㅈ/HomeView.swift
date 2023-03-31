//
//  HomeView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/14.
//

import SwiftUI

struct HomeView: View {
    
    @State var showMenu = false
    @State var showNewPostView = false
    @ObservedObject var vm = HomeViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.posts) { post in
                            NewPost(post: post)
                        }
                    }
                }
                .padding(.vertical)
                
                Button {
                    showNewPostView.toggle()
                } label: {
                    Image(systemName: "pencil.line")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(colors: [Color.yellow, Color.green],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                                )
                                .frame(width: 50, height: 50)
                                .shadow(radius: 10)
                        )
                }
                .padding(.bottom, 20)
                .padding(.trailing, 40)
                .fullScreenCover(isPresented: $showNewPostView) {
                    WritingView()
                }
            }
            .onAppear(perform: vm.fetchPost)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

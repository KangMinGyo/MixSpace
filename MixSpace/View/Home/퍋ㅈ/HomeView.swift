//
//  HomeView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/14.
//

import SwiftUI

struct HomeView: View {
    
    @State var showMenu = false
    @ObservedObject var vm = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(vm.posts) { post in
                        NewPost(post: post)

                    }
                }
            }
            .padding(.vertical)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

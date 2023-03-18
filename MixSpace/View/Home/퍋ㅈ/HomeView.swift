//
//  HomeView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/14.
//

import SwiftUI

struct HomeView: View {
    
    @State var showMenu = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(0...20, id: \.self) { num in
                        NewStarPost()

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

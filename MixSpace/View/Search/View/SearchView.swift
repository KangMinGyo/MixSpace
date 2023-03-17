//
//  SearchView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0...20, id: \.self) { _ in
                            NavigationLink {
                                ProfileView()
                            } label: {
                                UserRowProfile()
                            }

                        }
                    }
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

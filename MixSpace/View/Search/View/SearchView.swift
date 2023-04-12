//
//  SearchView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $vm.searchText)
                    .padding(.horizontal, 4)

                ScrollView {
                    LazyVStack {
                        ForEach(vm.searchableUsers, id: \.self) { user in
                            NavigationLink {
                                UserProfileView(user: user)
                            } label: {
                                UserRowProfile(user: user)
                            }

                        }
                    }
                }
                .onTapGesture {
                    self.hideKeyboard()
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

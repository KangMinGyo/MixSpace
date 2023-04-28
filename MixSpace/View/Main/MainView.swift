//
//  MainView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import SwiftUI
import Firebase

struct MainView: View {
    
    @State var selection = 0
    let title = ["Home", "Heart", "Chat", "My"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    TabView(selection: $selection) {
                        HomeContentView()
                            .tabItem {
                                Image(systemName: "sun.max")
                                Text("Space")
                            }
                            .tag(0)
                        
                        SearchView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                            .tag(1)
                        
                        MainMessageView()
                            .tabItem {
                                Image(systemName: "message")
                                Text("Chat")
                            }
                            .tag(2)
                        
                        ProfileView()
                            .tabItem {
                                Image(systemName: "person.circle.fill")
                                Text("My")
                            }
                            .tag(3)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

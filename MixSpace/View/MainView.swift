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
    let title = ["Home", "Space", "+", "Heart","My"]
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selection) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "moonphase.new.moon")
                            Text("Space")
                        }
                        .tag(0)
                    Text("MySpace")
                        .tabItem {
                            Image(systemName: "moonphase.full.moon")
                            Text("MySpace")
                        }
                        .tag(1)
                    Text("+")
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("+")
                        }
                        .tag(2)
                    Text("Heart")
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Heart")
                        }
                        .tag(3)
                    MyView()
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            Text("My")
                        }
                        .tag(4)
                    
                }
                .navigationTitle(title[selection])
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

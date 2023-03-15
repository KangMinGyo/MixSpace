//
//  HomeView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/14.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @AppStorage("logStatus") var logStatus = false
    @State var selection = 0
    let title = ["Home", "Space", "+", "Heart","My"]
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selection) {
                    homeView
                        .tabItem {
                            Image(systemName: "moonphase.new.moon")
                            Text("Home")
                        }
                        .tag(0)
                    Text("space")
                        .tabItem {
                            Image(systemName: "moonphase.full.moon")
                            Text("space")
                        }
                        .tag(1)
                    Text("space")
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("space")
                        }
                        .tag(2)
                    Text("space")
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("space")
                        }
                        .tag(3)
                    profileView
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private var homeView: some View {
        ScrollView {
            LazyVStack {
                ForEach(0...20, id: \.self) { num in
                    NewStarPost()
                    Divider()
                }
            }
        }
    }
    
    private var profileView: some View {
        
        VStack {
            Text("애플 로그인 완료")
        
            Button {
                DispatchQueue.global(qos: .background).async {
                    try? Auth.auth().signOut()
                }
                
                withAnimation(.easeInOut) {
                    logStatus = false
                }
                
            } label: {
                Text("Log Out")
            }
        }

    }
}

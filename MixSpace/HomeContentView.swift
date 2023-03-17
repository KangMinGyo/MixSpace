//
//  HomeContentView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import SwiftUI

struct HomeContentView: View {
    
    @State var showMenu = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                HomeView()
                    .navigationBarHidden(showMenu)
                
                if showMenu {
                    ZStack {
                        Color(.black)
                            .opacity(0.25)
                    }.onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu = false
                        }
                    }
                }
                SideMenuView()
                    .frame(width: 250)
                    .offset(x: showMenu ? 0 : -250, y: 0)
                    .background(showMenu ? Color.white : Color.clear)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                        
                    } label: {
                        Image("Profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}

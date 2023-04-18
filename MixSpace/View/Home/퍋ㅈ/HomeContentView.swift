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
                            .opacity(showMenu ? 0.25 : 0.0)
                    }.onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu = false
                        }
                    }
                }
                SideMenuView()
                    .frame(width: 300)
                    .offset(x: showMenu ? 0 : -300, y: 0)
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
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color.gray)
                            .clipShape(Circle())
                    }
                }
            }
            .onAppear {
                showMenu = false
            }
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}

//
//  ContentView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/14.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("logStatus") var logStatus = false
    
    var body: some View {
        
        ZStack {
            if logStatus {
                MainView()
                
            } else {
                LoginView()
                    .environmentObject(LoginViewModel(didCompleteLoginProcess: {
                        
                    }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

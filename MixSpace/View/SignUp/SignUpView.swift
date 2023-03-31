//
//  SignUpView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/31.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("이메일")
                TextField(
                        "ex)space2023@space.com",
                        text: $email
                    )
                    .submitLabel(.done)
                    .onSubmit {
                        //로직
                    }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

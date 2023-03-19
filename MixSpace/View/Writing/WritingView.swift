//
//  WritingView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/19.
//

import SwiftUI

struct WritingView: View {
    
    @State private var caption = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Image("Profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                    
                    WritingArea(placeholder: "추억을 남겨보세요...", text: $caption)
                }
                
            }
            .navigationTitle("글 쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("등록")
                    }
                }
            }
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}

//
//  WritingArea.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/19.
//

import SwiftUI

struct TextArea: View {
    
    @Binding var text: String
    let placeholder: String
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                    .padding(4)
            
            if text.isEmpty {
                Text("\(placeholder)")
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }

        }
        .font(.body)
    }
}

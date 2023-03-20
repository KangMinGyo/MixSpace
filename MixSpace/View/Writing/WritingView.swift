//
//  WritingView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/19.
//

import SwiftUI

struct WritingView: View {
    //Image 관련
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    @State private var caption = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Button {
                        imagePickerPresented.toggle()
                    } label: {
                        let image = profileImage == nil ? Image(systemName: "photo.circle") : profileImage ?? Image(systemName: "photo.circle")
                            image
                                .resizable()
                                .foregroundColor(.gray)
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Rectangle())
                    }
                    .sheet(isPresented: $imagePickerPresented,
                           onDismiss: loadImage,
                           content: { ImagePicker(image: $selectedImage) })
                    
                    WritingArea(placeholder: "추억을 남겨보세요...", text: $caption)
                }
                .padding()
                
                Text("비밀글 체크")
                
            }
            .navigationTitle("글 쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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

extension WritingView {
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}


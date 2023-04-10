//
//  WritingView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/19.
//

import SwiftUI

struct WritingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var vm = WritingViewModel()
    
    @State private var privatePost = false
    @State private var privateComment = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Button {
                        vm.imagePickerPresented.toggle()
                    } label: {
                        let image = vm.profileImage == nil ? Image(systemName: "photo.circle") : vm.profileImage ?? Image(systemName: "photo.circle")
                            image
                                .resizable()
                                .foregroundColor(.gray)
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Rectangle())
                    }
                    .sheet(isPresented: $vm.imagePickerPresented, onDismiss: vm.shown) {
                        ImagePicker(image: $vm.selectedImage)
                    }
                    .fullScreenCover(isPresented: $vm.cropperShown, onDismiss: vm.loadImage) {
                        ImageCroppingView(shown: $vm.cropperShown,
                                          shownPicker: $vm.imagePickerPresented,
                                          image: vm.selectedImage!,
                                          croppedImage: $vm.croppedImage)
                    
                    }

                    TextArea(placeholder: "추억을 남겨보세요...", text: $vm.text)
                        .onTapGesture {
                            self.hideKeyboard()
                        }
                }
                .padding()
                
                Toggle(isOn: $privatePost) {
                    HStack {
                        Image(systemName: "lock")
                            .font(.title3)
                        
                        Text("나만보기")
                            .font(.callout)
                    }
                }
                .padding()
                
                Toggle(isOn: $privateComment) {
                    HStack {
                        Image(systemName: "bubble.left")
                            .font(.system(size: 16))
                        
                        Text("댓글허용")
                            .font(.callout)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .navigationTitle("글 쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.uploadPost()
                        dismiss()
                    } label: {
                        Text("등록")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
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
    
//    func loadImage() {
//        guard let selectedImage = vm.croppedImage else { return }
//        vm.profileImage = Image(uiImage: selectedImage)
//    }
    
    
//    func loadImage() {
//        guard let selectedImage = vm.selectedImage else { return }
//        profileImage = Image(uiImage: selectedImage)
//    }
}


//    .sheet(isPresented: $imagePickerPresented,
//           onDismiss: loadImage,
//           content: { ImagePicker(image: $vm.selectedImage)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        cropperShown.toggle()
//                    } label: {
//                        Text("추가")
//                            .foregroundColor(.primary)
//                    }
//                    .sheet(isPresented: $cropperShown){
//                        ImageCroppingView(shown: $cropperShown,
//                                          image: vm.selectedImage!,
//                                          croppedImage: $vm.croppedImage)
//                    }
//                }
//            }
//    })

//
//  ImageCropView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/03.
//

import SwiftUI

struct ImageCropView: View {
    var originalImage = UIImage(named: "Profile")
    @State var croppedImage:UIImage?
    @State var cropperShown = false
    
    var body: some View {
        VStack{
            Spacer()
            Text("Original")
            Image(uiImage: originalImage!)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Spacer()
            if croppedImage != nil {
                Text("Cropped")
                Image(uiImage: croppedImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
            }
            
            Button(action: {cropperShown = true}){
                Text("Go to cropper")
            }
            
            Spacer()
        }
//        .sheet(isPresented: $cropperShown){
//            ImageCroppingView(shown: $cropperShown, image: originalImage!, croppedImage: $croppedImage, shownPicker: <#Binding<Bool>#>)
//        }
    }
    
}


struct ImageCropView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCropView()
    }
}

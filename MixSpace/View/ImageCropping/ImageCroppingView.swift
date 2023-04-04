//
//  ImageCroppingView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/02.
//

import SwiftUI

var UniversalSafeOffsets = UIApplication.shared.windows.first?.safeAreaInsets

struct ImageCroppingView: View {
    @ObservedObject var vm = WritingViewModel()
    //These are the initial dimension of the actual image
    @State var imageWidth: CGFloat = 0
    @State var imageHeight: CGFloat = 0
    
    @Binding var shown: Bool
    @Binding var shownPicker: Bool
    
    @State var croppingOffset = CGSize(width: 0, height: 0)
    @State var croppingMagnification: CGFloat = 1
    
    var image:UIImage
    @Binding var croppedImage:UIImage?
    
    var body: some View {
        ZStack{
            //Black background
            Color.black
                .edgesIgnoringSafeArea(.vertical)
            VStack{
                Spacer()
                    .frame(height: UniversalSafeOffsets?.top ?? 0)
                HStack(alignment: .top){
                    Button(action: {shown = false}){
                        Text("취소")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Text("You may need to re-select your filter after cropping")
                        .font(.system(size: 12))
                        .foregroundColor(.init(white: 0.7))
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        let cgImage: CGImage = image.cgImage!
                        print("image: \(cgImage.width) x \(cgImage.height)")
                        let scaler = CGFloat(cgImage.width)/imageWidth
                        let dim:CGFloat = getDimension(w: CGFloat(cgImage.width), h: CGFloat(cgImage.height))
                        
                        let xOffset = (((imageWidth/2) - (getDimension(w: imageWidth, h: imageHeight) * croppingMagnification/2)) + croppingOffset.width) * scaler
                        let yOffset = (((imageHeight/2) - (getDimension(w: imageWidth, h: imageHeight) * croppingMagnification/2)) + croppingOffset.height) * scaler
                        print("xOffset = \(xOffset)")
                        let scaledDim = dim * croppingMagnification
                        
                        if let cImage = cgImage.cropping(to: CGRect(x: xOffset, y: yOffset, width: scaledDim, height: scaledDim)){
                            croppedImage = UIImage(cgImage: cImage)
                            print("cImage: \(cImage)")
                            shown = false
                            shownPicker = false
                        }
                        
                    }){
                        Text("완료")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    
                }
                .font(.system(size: 20))
                .padding()
                
                Spacer()
                ZStack{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .overlay(GeometryReader{geo -> AnyView in
                            DispatchQueue.main.async{
                                self.imageWidth = geo.size.width
                                self.imageHeight = geo.size.height
                            }
                            return AnyView(EmptyView())
                        })
                    
                    ViewFinderView(imageWidth: self.$imageWidth, imageHeight: self.$imageHeight, finalOffset: $croppingOffset, finalMagnification: $croppingMagnification)
                    
                    
                }
                .padding()
                Spacer()
            }
        }.edgesIgnoringSafeArea(.vertical)
    }
}

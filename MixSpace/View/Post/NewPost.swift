//
//  NewPlanet.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/15.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewPost: View {
    @ObservedObject var vm: NewPostViewModel
    @State private var shareButtonPressed = false
    @State var renderedImage: Image?
    
    init(post: Post) {
        self.vm = NewPostViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            if let user = vm.post.user {
                HStack {
                    WebImage(url: URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("@\(user.nickName)")
                            .font(.system(size: 15))
                            .bold()
                        Text("\(vm.post.time)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            
            WebImage(url: URL(string: vm.post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .cornerRadius(10)
                .clipped()
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Button {
                        //종아요
                        vm.post.didLike ?? false ? vm.unlikePost() : vm.likePost()
                    } label: {
                        Image(systemName: vm.post.didLike ?? false ? "heart.fill" : "heart")
                            .font(.title3)
                            .foregroundColor(vm.post.didLike ?? false ? Color.red : Color("SpaceBlue"))
                    }
                    Button {
                        //댓글
                    } label: {
                        Image(systemName: "bubble.left")
                            .font(.body)
                            .foregroundColor(Color("SpaceBlue"))
                    }
                    
                    Spacer()
                    AsyncImage(url: URL(string: vm.post.imageURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()

                            ShareLink(item: image, preview: SharePreview(vm.post.text, image: image)) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color("SpaceBlue"))
                            }
                        }
                    }.frame(width: 0, height: 0)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 4)

                Text(vm.post.text) //*
                    .font(.subheadline)
                
                HStack {
                    Text("좋아요 \(vm.post.like)개")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Text("댓글 0개")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 4)
            
        }
    }
}
//
//struct NewPost_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPost()
//    }
//}

extension Image {
    func data(url: URL) -> Image {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return Image("Profile")
    }
}

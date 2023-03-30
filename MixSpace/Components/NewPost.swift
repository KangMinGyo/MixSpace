//
//  NewPlanet.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/15.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewPost: View {
    let post: Post
    
    var body: some View {
        VStack() {
            
            if let user = post.user {
                HStack {
                    Image("Profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("@\(user.nickName)")
                            .font(.system(size: 15))
                            .bold()
                        Text("2023.03.15")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }

            WebImage(url: URL(string: post.imageURL))
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
                    } label: {
                        Image(systemName: "heart")
                            .font(.title3)
                            .foregroundColor(Color("SpaceBlue"))
                    }
                    Button {
                        // 공유
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 19))
                            .foregroundColor(Color("SpaceBlue"))
                    }
                }
                .padding(.bottom, 4)

                Text(post.text) //*
                    .font(.subheadline)
                
                HStack {
                    Text("좋아요 1개")
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

//struct NewPost_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPost()
//    }
//}

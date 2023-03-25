//
//  NewPlanet.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/15.
//

import SwiftUI

struct NewPost: View {
    var body: some View {
        VStack() {
            HStack {
                Image("Profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("주먹밥러버")
                        .font(.headline)
                    Text("2023.03.15")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Image("Photo")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .cornerRadius(10)
                .clipped()
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .font(.title3)
                            .foregroundColor(Color("SpaceBlue"))
                    }
                }
                .padding(.bottom, 4)
                
                Text("주먹밥 만든 날")
                    .font(.system(size: 15))
                    .bold()
                
                Text("오늘 떡잎마을방범대 친구들과 주먹밥을 만들었다!")
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
        Divider()
    }
}

struct NewPost_Previews: PreviewProvider {
    static var previews: some View {
        NewPost()
    }
}

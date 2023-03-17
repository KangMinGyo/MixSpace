//
//  NewPlanet.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/15.
//

import SwiftUI

struct NewStarPost: View {
    var body: some View {
        VStack() {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 36))
                VStack(alignment: .leading) {
                    Text("Mango")
                        .font(.headline)
                    Text("2023.03.15")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Image("TestImage")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .cornerRadius(10)
                .clipped()
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("거제 정글돔 놀러가기!")
                    .font(.headline)
                
                Text("오늘 정글돔 새 둥지에서 사진 찍음 ㅎㅎ")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "star.bubble.fill")
                        .font(.title3)
                        .foregroundColor(Color("SpaceBlue"))
                }
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .font(.title3)
                        .foregroundColor(Color("SpaceBlue"))
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .foregroundColor(Color("SpaceBlue"))
                }

            }
            .frame(alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        Divider()
    }
}

struct NewStarPost_Previews: PreviewProvider {
    static var previews: some View {
        NewStarPost()
    }
}

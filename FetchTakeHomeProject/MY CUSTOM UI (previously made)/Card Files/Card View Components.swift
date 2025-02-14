//
//  Card View Components.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/25/24.
//

import SwiftUI

struct CardInfoIcon: View {
    var image: Image
    var title: String
    
    var body: some View {
        Label {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
        } icon: {
            image
                .resizable()
                .foregroundStyle(Color.black)
                .scaledToFit()
        }
        .padding(4)
        .background(Color.white)
        .frame(height: 30)
        .clipShape(Capsule())
    }
}

struct HeartButton: View {
    var foregroundColor: Color = .white
    var toggled: (Bool)->Void
    
    @State private var toggleHeart = false
    
    var body: some View {
        Button {
            toggleHeart.toggle()
            toggled(toggleHeart)
        } label: {
            Image(systemName: "heart.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(foregroundColor)
                .background(toggleHeart == true ? Color.red : Color.clear)
                .clipShape(Circle())
        }
        .animation(.bouncy, value: toggleHeart)
    }
}


//
//  ProfileAvatarView.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/26/24.
//

import SwiftUI

struct ProfileAvatarView: View {
    var image: Image

    var body: some View {
        image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .padding(12)
            .background(Color.gray)
            .foregroundStyle(Color.secondaryAccent)
            .clipShape(Circle())
    }
}

#Preview {
    ProfileAvatarView(image: Image(systemName: "person"))
        .frame(width: 140, height: 140)
}

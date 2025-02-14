//
//  RecipeImageVie.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

// This view is essentially a custom implementation of Apples own AsyncImage view.
struct RecipeImageView: View {
    var urlString: String
    var id: String
    
    @StateObject var loader = RecipeImageViewModel()

    init(urlString: String, id: String) {
        self.urlString = urlString
        self.id = id
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.uiimage {
                Image(uiImage: image)
                    .resizable()
//                    .recipeImageModifier()
            }
        }
//        .recipeImageModifier()
        .task { try? await loader.loadImage(from: urlString, or: id) }
    }
    
}



// MARK: Recipe Image view modifier.
extension View {
    func recipeImageModifier() -> some View {
        self.modifier(RecipeImageModifier())
    }
}

struct RecipeImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            // add modfifiers here
            .clipShape(.rect(cornerRadius: 8))
            .background(Color.gray)
    }
}


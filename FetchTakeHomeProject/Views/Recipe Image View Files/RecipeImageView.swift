//
//  RecipeImageVie.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

// This view is essentially a custom implementation of Apples own AsyncImage view. With one feature, a reload button in the case the image does not load properly.
struct RecipeImageView: View {
    var recipe: Recipe
    var reloadAction: (()->())? // An action to perform
    
    @StateObject var loader = RecipeImageViewModel()

    init(recipe: Recipe, reloadAction: (()->())? = nil) {
        self.recipe = recipe
        self.reloadAction = reloadAction
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.uiimage {
                Image(uiImage: image)
                    .resizable()
                    .recipeImageModifier()
            } else if loader.isLoading == false && loader.uiimage == nil {
                reloadButton
            }
        }
        .recipeImageModifier()
        .task { try? await loader.fetchImage(from: recipe.photoURLLarge, or: recipe.uuid) }
    }
    
    
    
    fileprivate var reloadButton: some View {
        Button {
            reloadAction?()
        } label: {
            Image(systemName: "arrow.counterclockwise")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color.white)
                .frame(width: 14, height: 14)
        }
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
            .frame(width: 44, height: 44)
            .clipShape(.rect(cornerRadius: 8))
            .background(Color.gray)
    }
}


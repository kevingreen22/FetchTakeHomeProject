//
//  MainViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [] // a publisher containing recipes updated from the data manager's fetch.
    @Published var showError: Bool = false
    
    let dataManager = RecipeDataManager.instance
    
    /// Loads recipies fetched from the data manager.
    /// The thrown errors coming back to this method stop here and trigger the show error bool.
    /// The actual error message being show in the alert have been ommitted and generalized for the brefity of this project.
    func loadRecipes() async {
        print("\(type(of: self)).\(#function)")
        do {
            try await self.dataManager.fetchRecipeData(with: APIURLs.recipesURL)
            self.recipes = self.dataManager.recipes
            print("  _recipes loaded.")
        } catch {
            print("  _failied to load recipes: \(error)")
            showError.toggle()
        }
    }
    
}


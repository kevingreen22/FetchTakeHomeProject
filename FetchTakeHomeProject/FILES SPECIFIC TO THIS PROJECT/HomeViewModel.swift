//
//  HomeViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [] // a publisher containing recipes updated from the data manager's fetch.
    @Published var cuisines: Dictionary<String, Set<Card>> = [:]
    @Published var showError: Bool = false
    
    let dataManager = RecipeDataManager.instance
    
    /// Loads recipies fetched from the data manager.
    /// The thrown errors coming back to this method stop here and trigger the show error bool.
    /// The actual error message being show in the alert have been ommitted and generalized for the brefity of this project.
    func loadRecipes() async {
        print("\(type(of: self)).\(#function)")
        do {
            try await self.dataManager.fetchRecipeData(with: APIURLs.recipesURL) // <-- CHANGE URL ENDPOINT HERE
            self.recipes = self.dataManager.recipes
            print("  _recipes loaded, categorizing...")
            await categorizeRecipies()
            print("  _categorized.")
        } catch {
            print("  _failied to load recipes: \(error)")
            showError.toggle()
        }
    }
    
    func categorizeRecipies() async {
        print("\(type(of: self)).\(#function)")
        var dict: Dictionary<String, Set<Card>> = Dictionary(minimumCapacity: recipes.count)
        
        for recipe in recipes {
            let card = Card(
                title: recipe.name,
                imageURLString: recipe.photoURLLarge,
                altText: nil,
                detailText: nil,
                hearts: nil,
                stars: nil,
                cardInfoIcon: getCardInfoIcon(Int.random(in: 0...2)))
            
            if var recipesInCategory = dict[recipe.cuisine] {
                recipesInCategory.insert(card)
                dict.updateValue(recipesInCategory, forKey: recipe.cuisine)
            } else {
                dict.updateValue([card], forKey: recipe.cuisine)
            }
        }
        self.cuisines = dict
    }
    
    
    fileprivate func getCardInfoIcon(_ int: Int) -> CardInfoIcon {
        switch int {
        case 0: return CardInfoIcon(image: Image(systemName: "gauge.low"), title: "Easy")
        case 1: return CardInfoIcon(image: Image(systemName: "gauge.medium"), title: "Moderate")
        default: return CardInfoIcon(image: Image(systemName: "gauge.high"), title: "Advanced")
        }
    }
    
}


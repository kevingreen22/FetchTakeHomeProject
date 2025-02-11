//
//  DataManager.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

/// The 3 endpoints provided.
struct APIURLs {
    static let recipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")

    static let malformedDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
    
    static let emptyDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
}

/// A singleton managing the fetching of data from a url.
class RecipeDataManager {
    
    var recipes: [Recipe] = [] // The decoded JSON Recipe objects.
    static let instance = RecipeDataManager() // Singleton reference.
    private let session = URLSession(configuration: .ephemeral) // .ephimeral stops the URLSession from caching the images so we can use our own caching implementation. However using the .default URLSession configuration would be enough to cache the images.

    private init() { }
    
    
    /// Fetches an array of recipies from a url as a Response object.
    func fetchRecipeData(with url: URL?) async throws {
        print("\(type(of: self)).\(#function)")
        guard let url = url else {
            print("  _bad url, cannot connect to endpoint.")
            throw URLError(.badURL)
        }
        
        do {
            let (data,_) = try await session.data(from: url)
            let response = try JSONDecoder().decode(Response.self, from: data)
            for recipe in response.recipes {
                self.recipes.append(recipe)
            }
            print("  _data decoded successfully.")
        } catch {
            print("  _error downloading data: \(error)")
            throw error
        }
    }
    
}

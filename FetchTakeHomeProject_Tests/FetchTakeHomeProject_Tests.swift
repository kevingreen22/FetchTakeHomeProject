//
//  FetchTakeHomeProject_Tests.swift
//  FetchTakeHomeProject_Tests
//
//  Created by Kevin Green on 2/10/25.
//

import Testing
import SwiftUI
@testable import FetchTakeHomeProject

struct RecipeDataManager_Tests {
    let rdm = RecipeDataManager.instance
    
    @Test("Bad URL throws")
    func fetchRecipeData_withBadURL() async throws {
        let url = URL(string: "")
        await #expect(throws: URLError(.badURL), performing: {
            try await rdm.fetchRecipeData(with: url)
        })
    }
    
    @Test("Malformed URL throws")
    func fetchRecipeDataThrowsErrorwithMalformedURL() async throws {
        await #expect(throws: Error.self, performing: {
            try await rdm.fetchRecipeData(with: APIURLs.malformedDataURL)
        })
    }
    
    @Test("Good URL")
    func fetchRecipeDataRecipesNotEmptyWithGoodURL() async throws {
        try await rdm.fetchRecipeData(with: APIURLs.recipesURL)
        #expect(!rdm.recipes.isEmpty)
    }
    
}


struct ImageCacheManager_Tests {
    let icm = ImageCacheManager.instance
    
    @Test("Add image to cache")
    func imageAddedToCache() {
        let key = UUID()
        let image = UIImage(systemName: "photo")!
        icm.add(key: key.uuidString, value: image)
        
        #expect(icm.imagesCache.object(forKey: key.uuidString as NSString) != nil)
    }
    
    @Test("Get image from cache")
    func canGetImageFromCache() async throws {
        // add the image
        let key = UUID()
        let image = UIImage(systemName: "photo")!
        icm.add(key: key.uuidString, value: image)
        
        #expect(icm.getUIImageFor(key: key.uuidString) != nil)
    }
    
    
    
}


struct MainViewModel_Tests {
    let rdm = RecipeDataManager.instance
    @MainActor let vm = MainViewModel()
    
    @Test("Recipes variable populated with good URL")
    func recipesDidPopulate() async throws {
        try await rdm.fetchRecipeData(with: APIURLs.recipesURL)
        await vm.loadRecipes()
        await #expect(!vm.recipes.isEmpty)
    }
    
}


struct RecipeImageViewModel_Tests {
    @MainActor let vm = RecipeImageViewModel()
    
    @Test("Fetch image does throw bad URL")
    func fetchImageDoesThrowBadURL() async throws {
        await #expect(throws: URLError(.badURL), performing: {
            try await vm.fetchImage(for: "", cacheKey: UUID().uuidString)
        })
    }
    
    @Test("UIImage does get set")
    func imageDoesSet() async throws {
        let key = UUID()
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"
        
        try await vm.fetchImage(for: urlString, cacheKey: key.uuidString)
        
        await #expect(vm.uiimage != nil)
    }
    
}

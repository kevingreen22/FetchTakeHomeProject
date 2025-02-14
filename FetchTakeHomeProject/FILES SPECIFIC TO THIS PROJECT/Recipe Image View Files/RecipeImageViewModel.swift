//
//  RecipeImageViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/9/25.
//

import SwiftUI

@MainActor
final class RecipeImageViewModel: ObservableObject {
    @Published var uiimage: UIImage?
    @Published var isLoading: Bool = true
    
    let recipeImageDataManager = RecipeImageDataManager.instance
    let imageCache = ImageCacheManager.instance // Singleton instance
    
    init() { }
    
    
    /// Fetches the Image from a cache via a key OR from a url string sent to a data manager, then sets this classe's UIImage accordingly.
    /// If the image must be fetched via the url, it is then cached.
    func loadImage(from urlString: String, or cacheKey: String) async throws {
        print("\(type(of: self)).\(#function)")
        
        if let uiimage = imageCache.getUIImageFor(key: cacheKey) {
            print("  _from image cache")
            self.uiimage = uiimage
            isLoading = false
        } else {
            do {
                let uiimage = try await self.recipeImageDataManager.fetchImageFrom(urlString: urlString)
                print("  _from image data manager")
                self.uiimage = uiimage
                imageCache.add(key: cacheKey, value: uiimage)
                isLoading = false
            } catch {
                print("  _failied to load image: \(error)")
                isLoading = false
                throw error
            }
        }
    }
    
}


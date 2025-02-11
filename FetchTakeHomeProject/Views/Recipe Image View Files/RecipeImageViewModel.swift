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
    
    private let session = URLSession(configuration: .ephemeral) // .ephimeral stops the URLSession from caching the images so we can use our own caching implementation. However using the .default URLSession configuration would be enough to cache the images.
    
    let imageCache = ImageCacheManager.instance // Singleton instance
    
    init() { }
    
    
    /// Fetches the Image from a cache via a key OR from a url string, then sets the classe's UIImage accordingly.
    /// If the image must be fetched via the url, it is then cached.
    func fetchImage(from urlString: String, or cacheKey: String) async throws {
        print("\(type(of: self)).\(#function)")
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        if let uiimage = imageCache.getUIImageFor(key: cacheKey) {
            print("  _from image cache")
            self.uiimage = uiimage
            isLoading = false
        } else {
            do {
                let (data,_) = try await session.data(from: url)
                guard let uiimage = UIImage(data: data) else { throw URLError(.cannotDecodeRawData) }
                print("  _from data manager")
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


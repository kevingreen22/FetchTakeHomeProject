//
//  RecipeImageDataManager.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/12/25.
//

import SwiftUI

/// A singleton managing the fetching of data from a url.
class RecipeImageDataManager {
    
    static let instance = RecipeImageDataManager() // Singleton reference.
    private let session = URLSession(configuration: .ephemeral) // .ephimeral stops the URLSession from caching the images so we can use our own caching implementation. However using the .default URLSession configuration would be enough to cache the images.
    
    private init() { }
    
    func fetchImageFrom(urlString: String) async throws -> UIImage {
        print("\(type(of: self)).\(#function)")
        guard let url = URL(string: urlString) else {
            print("  _bad url, cannot connect to endpoint.")
            throw URLError(.badURL)
        }
        
        do {
            let (data,_) = try await session.data(from: url)
            guard let uiimage = UIImage(data: data) else { throw URLError(.cannotDecodeRawData) }
            print("  _image data decoded successfully.")
            return uiimage
        } catch {
            print("  _error downloading data: \(error)")
            throw error
        }
    }
    
}

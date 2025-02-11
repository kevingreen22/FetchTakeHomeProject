//
//  ImageCacheManager.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

/// A singleton image cache manager.
class ImageCacheManager {
    
    static let instance = ImageCacheManager() // Singleton instance.
    private init() { }
    
    /// NSCache of NSString to UIImage
    var imagesCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // Limiting the number the cache can hold.
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb - Limiting the total megabytes allowed.
        return cache
    }()
    
    
    func add(key: String, value: UIImage) {
//        print("\(type(of: self)).\(#function)")
        imagesCache.setObject(value, forKey: key as NSString)
    }
    
    func getUIImageFor(key: String) -> UIImage? {
//        print("\(type(of: self)).\(#function)")
        return imagesCache.object(forKey: key as NSString)
    }
    
}

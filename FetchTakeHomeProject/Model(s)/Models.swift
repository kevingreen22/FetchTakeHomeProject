//
//  Models.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import Foundation

//"recipes": [
//        {
//          ...
//        }
//    ]

struct Response: Decodable {
    var recipes: [Recipe]
}


//      ...
//        {
//            "cuisine": "British",
//            "name": "Bakewell Tart",
//            "photo_url_large": "https://some.url/large.jpg",
//            "photo_url_small": "https://some.url/small.jpg",
//            "source_url": "https://some.url/index.html",
//            "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
//            "youtube_url": "https://www.youtube.com/watch?v=some.id"
//        },
//        ...

struct Recipe: Codable, Hashable, Equatable {
    var cuisine: String
    var name: String
    var photoURLLarge: String
    var photoURLSmall: String
    var sourceURL: String?
    var uuid: String
    var youtubeURL: String?
    
    init(cuisine: String, name: String, photoURLLarge: String, photoURLSmall: String, sourceURL: String?, uuid: String, youtubeURL: String?) {
        self.cuisine = cuisine
        self.name = name
        self.photoURLLarge = photoURLLarge
        self.photoURLSmall = photoURLSmall
        self.sourceURL = sourceURL
        self.uuid = uuid
        self.youtubeURL = youtubeURL
    }
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
    
    // Equatable conformance
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.cuisine == rhs.cuisine &&
        lhs.name == rhs.name &&
        lhs.photoURLLarge == rhs.photoURLLarge &&
        lhs.photoURLSmall == rhs.photoURLSmall &&
        lhs.uuid == rhs.uuid &&
        lhs.sourceURL == rhs.sourceURL &&
        lhs.youtubeURL == rhs.youtubeURL
    }
    
    // Hashable confomance
    func hash(into hasher: inout Hasher) {
        hasher.combine(cuisine)
        hasher.combine(name)
        hasher.combine(photoURLLarge)
        hasher.combine(photoURLSmall)
        hasher.combine(uuid)
        hasher.combine(sourceURL)
        hasher.combine(youtubeURL)
    }
    
}

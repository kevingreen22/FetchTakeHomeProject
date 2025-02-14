//
//  Card Model.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/25/24.
//

import SwiftUI

// MARK: CARD MODELs
protocol CardData {
    var cardData: [Card] { get }
    var cardViewStyle: CardViewStyle { get set }
}

class Card: Identifiable, Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageURLString == rhs.imageURLString &&
        lhs.altText == rhs.altText &&
        lhs.detailText == rhs.detailText &&
        lhs.hearts == rhs.hearts &&
        lhs.stars == rhs.stars
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(imageURLString)
        hasher.combine(altText)
        hasher.combine(detailText)
        hasher.combine(hearts)
        hasher.combine(stars)
    }
    
        
    var id: String = UUID().uuidString
    var title: String
    var imageURLString: String
    var altText: String?
    var detailText: String?
    var hearts: Int?
    var stars: Double?
    var cardInfoIcon: CardInfoIcon?
    
    init(title: String, imageURLString: String, altText: String? = nil, detailText: String? = nil, hearts: Int? = nil, stars: Double? = nil, cardInfoIcon: CardInfoIcon? = nil) {
        self.title = title
        self.imageURLString = imageURLString
        self.altText = altText
        self.detailText = detailText
        self.hearts = hearts
        self.stars = stars
        self.cardInfoIcon = cardInfoIcon
    }
}

protocol CardViewProtocol {
    var cardViewStyle: CardViewStyle { get }
    var title: String { get }
    var imageURLString: String { get }
    var id: String { get }
}

enum CardViewStyle: CaseIterable {
    case basicCompact
    case basicWide
    case basicMedium
    case basicLarge
    
    case detailLarge
    case detailMedium
    case detailCompact
    
    var size: CGSize {
        switch self {
        case .basicCompact: CGSize(width: 130, height: 80)
        case .basicWide: CGSize(width: 0, height: 80)
        case .basicMedium: CGSize(width: 125, height: 200)
        case .basicLarge: CGSize(width: 0, height: 100)

        case .detailCompact: CGSize(width: 125, height: 200)
        case .detailMedium: CGSize(width: 250, height: 200)
        case .detailLarge: CGSize(width: 250, height: 400)
        
        }
    }
    
    static var random: CardViewStyle {
        switch Int.random(in: 0...6) {
        case 1: return .basicCompact
        case 2: return .basicWide
        case 3: return .basicMedium
        case 4: return .basicLarge
        case 5: return .detailCompact
        case 6: return .detailMedium
        default: return .detailLarge
        }
    }
    
    static func get(style: CardViewStyle, with card: Card) -> some View {
        switch style {
        case .basicCompact:
            CardView(cardViewStyle: .basicCompact, imageURLString: card.imageURLString, id: card.id, title: card.title)
            
        case .basicWide:
            CardView(cardViewStyle: .basicWide, imageURLString: card.imageURLString, id: card.id, title: card.title)
            
        case .basicMedium:
            CardView(cardViewStyle: .basicMedium, imageURLString: card.imageURLString, id: card.id, title: card.title)
            
        case .basicLarge:
            CardView(cardViewStyle: .basicLarge, imageURLString: card.imageURLString, id: card.id, title: card.title)
        
            
        case .detailCompact:
            CardView(cardViewStyle: .detailCompact, imageURLString: card.imageURLString, id: card.id, title: card.title, hearts: card.hearts?.formatted(), stars: card.stars?.formatted(.number), cardInfoIcon: card.cardInfoIcon)
        
        case .detailMedium:
            CardView(cardViewStyle: .detailMedium, imageURLString: card.imageURLString, id: card.id, title: card.title, hearts: card.hearts?.formatted(), stars: card.stars?.formatted(.number), cardInfoIcon: card.cardInfoIcon)
            
        case .detailLarge:
            CardView(cardViewStyle: .detailLarge, imageURLString: card.imageURLString, id: card.id, title: card.title, hearts: card.hearts?.formatted(), stars: card.stars?.formatted(.number), cardInfoIcon: card.cardInfoIcon)
        }
    }
}


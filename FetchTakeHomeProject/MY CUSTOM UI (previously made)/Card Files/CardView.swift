//
//  CardView.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/22/24.
//

import SwiftUI

// MARK: Card View
struct CardView: View, CardViewProtocol {
    var cardViewStyle: CardViewStyle
    var imageURLString: String
    var id: String
    var title: String
    var altText: String?
    var detailText: String?
    var hearts: String?
    var stars: String?
    var cardInfoIcon: CardInfoIcon?
    private var screenWidth: CGFloat {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window,
              let width = window?.frame.width
        else {
            return UIScreen.main.bounds.width - 32
        }
        return width
    }
    
    
    init(cardViewStyle: CardViewStyle, imageURLString: String, id: String, title: String, altText: String? = nil, detailText: String? = nil, hearts: String? = nil, stars: String? = nil, cardInfoIcon: CardInfoIcon? = nil) {
        self.cardViewStyle = cardViewStyle
        self.imageURLString = imageURLString
        self.id = id
        self.title = title
        self.altText = altText
        self.detailText = detailText
        self.hearts = hearts == nil ? "-" : hearts
        self.stars = stars == nil ? "-" : stars
        self.cardInfoIcon = cardInfoIcon
    }
    
    var body: some View {
        switch cardViewStyle {
        case .basicCompact:
            Group {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundStyle(Color.white)
                    .frame(width: cardViewStyle.size.width, height: cardViewStyle.size.height)
                    .shadow(radius: 8, x: -4, y: 4)
                    .overlay {
                        HStack(spacing: 0) {
                            Text(title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding()
                            RecipeImageView(urlString: imageURLString, id: id)
                                .recipeImageModifier()
                                .frame(width: cardViewStyle.size.width/2)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
            }
            
        case .basicWide:
            Group {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundStyle(Color.white)
                    .frame(width: screenWidth, height: cardViewStyle.size.height)
                    .shadow(radius: 8, x: -4, y: 4)
                    .overlay {
                        HStack(spacing: 0) {
                            Text(title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            RecipeImageView(urlString: imageURLString, id: id)
                                .recipeImageModifier()
                                .padding([.vertical, .trailing])
                                .frame(width: cardViewStyle.size.height, height: cardViewStyle.size.height)
                                .aspectRatio(contentMode: .fit)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
            }
            
        case .basicMedium:
            Group {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)
                    .overlay(alignment: .top) {
                        VStack {
                            RecipeImageView(urlString: imageURLString, id: id)
                                .recipeImageModifier()
                                .frame(width: cardViewStyle.size.width, height: cardViewStyle.size.width)
                                .overlay(alignment: .topLeading) {
                                    cardInfoIcon?.padding([.top, .leading], 8)
                                }
                            
                            Text(detailText ?? title)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .lineLimit(3)
                                .truncationMode(.tail)
                                .padding( 4)
                        }
                    }
                    .frame(width: cardViewStyle.size.width, height: cardViewStyle.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(radius: 8, x: -4, y: 4)
            }
            
        case .basicLarge:
            Group {
                HStack(alignment: .top, spacing: 16) {
                    RecipeImageView(urlString: imageURLString, id: id)
                        .recipeImageModifier()
                        .frame(width: cardViewStyle.size.height, height: cardViewStyle.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .shadow(radius: 8, x: -4, y: 4)
                    
                    Rectangle().fill(Color.clear)
                        .overlay(alignment: .topLeading) {
                            Text(altText?.uppercased() ?? "")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                        .overlay(alignment: .leading) {
                            Text(title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                }
                .padding(.horizontal)
            }
            
            
        case .detailCompact:
            Group {
                VStack(spacing: 5) {
                    RecipeImageView(urlString: imageURLString, id: id)
                        .recipeImageModifier()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .shadow(radius: 8, x: -4, y: 4)
                        .overlay(alignment: .topLeading) {
                            cardInfoIcon?.padding([.top, .leading], 8)
                        }
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Label("\(hearts ?? "-")", systemImage: "heart").font(.caption2)
                            Label("\(stars ?? "-")", systemImage: "star").font(.caption2)
                            Spacer()
                            HeartButton(foregroundColor: .gray) { hearted in
                                // do something
                            }.scaleEffect(0.8)
                        }
                        
                        Text(title)
                            .font(.caption)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .truncationMode(.tail)
                            .padding(.trailing, 16)
                            .padding([.leading, .bottom], 8)
                    }
                }
                .frame(width: cardViewStyle.size.width, height: cardViewStyle.size.height)
            }
            
        case .detailMedium, .detailLarge:
            Group {
                RecipeImageView(urlString: imageURLString, id: id)
                    .recipeImageModifier()
                    .overlay(alignment: .bottomLeading) {
                        Rectangle()
                            .fill(
                                Gradient(colors: [Color.clear, Color.black.opacity(0.4),Color.black.opacity(0.6),Color.black.opacity(0.8),Color.black.opacity(0.95)])
                            )
                            .overlay(alignment: .bottomLeading) {
                                VStack(alignment: .leading) {
                                    Text(altText ?? "")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.gray)
                                        .padding(.vertical, 12)
                                    Text(title)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                    HStack {
                                        Label("\(hearts ?? "-")", systemImage: "heart.fill").font(.caption)
                                        Label("\(stars ?? "-")", systemImage: "star.fill").font(.caption)
                                    }
                                }
                                .padding([.leading, .bottom], 8)
                            }
                            .frame(height: cardViewStyle.size.height/3)
                    } // main content
                    .overlay(alignment: .bottomTrailing) {
                        HeartButton { hearted in
                            // do some work when hearted/un-hearted
                            
                        }
                        .padding([.bottom, .trailing], 16)
                    } // heart button
                    .overlay(alignment: .topLeading) {
                        cardInfoIcon?.padding([.leading, .top], 16)
                    } // card info icon
                    .foregroundStyle(Color.white)
                    .frame(width: cardViewStyle.size.width, height: cardViewStyle.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(radius: 8, x: -4, y: 4)
            }
        }
    }
}


// MARK: Card Scroll View
struct CardScrollView: View, CardData {
    var sectionTitle: String?
    var cardData: [Card]
    var cardViewStyle: CardViewStyle
    var backgroundColor: Color = .clear
    
    var body: some View {
        VStack {
            if let sectionTitle {
                SectionHeader(title: sectionTitle, count: cardData.count) { }
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(cardData, id: \.id) { card in
                        CardViewStyle.get(style: cardViewStyle, with: card)
                    }
                }
                .padding(.vertical, 20)
            }
            
//            .scrollClipDisabled() // <-- ios 18 only
            
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
        .background(backgroundColor)
    }
        
}


// MARK: Card Stack View
struct CardStackView: View, CardData {
    var numDataInStack: Int = 3
    var sectionTitle: String?
    var cardData: [Card]
    var cardViewStyle: CardViewStyle
    var backGroundColor: Color = .clear
    var withDividers: Bool = false
    
    
    var body: some View {
        VStack(spacing: 16) {
            if let sectionTitle {
                SectionHeader(title: sectionTitle) { }
            }
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(0..<numDataInStack, id: \.self) { index in
                    if index <= cardData.count+1 {
                        CardViewStyle.get(style: cardViewStyle, with: cardData[index]).padding(.horizontal)
                        if withDividers && index < numDataInStack-1 {
                            Divider()
                        }
                    }
                }
            }
        }
        .padding(.bottom, 20)
        .background(backGroundColor)
    }
}


fileprivate struct SectionHeader: View {
    var title: String
    var count: Int?
    var action: (()->())?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.secondaryAccent)
                .padding(.leading)
            
            Spacer()
            if let action = action?() {
                Button {
                    // button action here
                    action
                } label: {
                    HStack {
                        Text("View All")
                            .font(.caption)
                            .foregroundStyle(Color.secondaryAccent)
                            
                        if count != nil {
                            Text("(\(count!))")
                                .font(.caption)
                                .fontWeight(.thin)
                                .foregroundStyle(Color.secondaryAccent)
                        }
                    }.padding(.trailing)
                }
            }
        }
    }
}


#Preview {
    MainTabView()
}

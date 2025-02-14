//
//  HomeView.swift
//  StandardTabViewApp
//
//  Created by Kevin Green on 10/22/24.
//


import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var headerImage: Image = Image(systemName: "")
    @State private var headerText: String = "Day"
    @State private var searchBarOffset: CGFloat = 0
    @State private var searchBarOpacity: CGFloat = 1
    
    init() {}
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                header()
                
                if vm.recipes.isEmpty {
                    emptyRecipesText
                } else {
                    ForEach(Array(vm.cuisines.keys), id: \.self) { key in
                        if vm.cuisines[key] != nil, let cardData = vm.cuisines[key] {
                            CardScrollView(sectionTitle: key.capitalized, cardData: cardData.map({$0}), cardViewStyle: .detailMedium).padding(.vertical,8)
                        }
                    }
                }
                
                Spacer(minLength: 80)
            }
            .background(Color.accentColor.gradient)
            .refreshable { await refresh() }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .alert(Text("Uh oh"), isPresented: $vm.showError) {
                Button("OK") { /* Handle acknowledgement here */ }
            } message: {
                Text("There was a problem getting yummy recipies to make. Try refreshing.")
            }
            
            .task {             // <-- first call of data fetch.
                setHeaderInfo()
                await refresh()
            }
                        
            //            .onScrollGeometryChange(for: Bool.self) { geometry in
            //                if geometry.contentOffset.y < 90 {
            //                    return false
            //                }
            //                return true
            //            } action: { oldValue, newValue in
            //                if newValue {
            //                    searchBarOffset = -100
            //                    searchBarOpacity = 0
            //                } else {
            //                    searchBarOffset = 0
            //                    searchBarOpacity = 1
            //                }
            //            }
            
            searchAndProfileSection(uiimage: nil)
                .offset(y: searchBarOffset)
                .opacity(searchBarOpacity)
                .animation(.smooth, value: searchBarOffset)
                .animation(.smooth, value: searchBarOpacity)
        } // end zstack
    } // end body
    
    fileprivate func refresh() async {
        await vm.loadRecipes()
    }
    
    fileprivate func searchAndProfileSection(uiimage: UIImage?) -> some View {
        HStack(spacing: 10) {
            Capsule(style: .continuous)
                .foregroundStyle(Color.white)
                .overlay(alignment: .leading) {
                    Label("Search...", systemImage: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
            
            ProfileAvatarView(image: Image(uiImage: uiimage ?? UIImage(systemName: "person")!))
        }
        .frame(height: 40)
        .shadow(radius: 8)
        .padding([.horizontal, .top])
        
    }
    
    fileprivate func header() -> some View {
        VStack(alignment: .leading) {
            headerImage
                .resizable()
                .frame(height: 200)
                .scaledToFit()
                .transition(.opacity)
            
            Text("Good \(headerText)!")
                .font(.largeTitle)
                .foregroundStyle(Color.secondaryAccent)
                .padding(.leading)
                .transition(.opacity)
        }
        .padding(.bottom, 20)
    }
    
    fileprivate func setHeaderInfo() {
        let circadianInterval = Date().getCircadianInterval()
        headerImage = Image(circadianInterval.rawValue.lowercased())
        headerText = circadianInterval.rawValue
    }
    
    fileprivate var emptyRecipesText: some View {
        VStack {
            HStack {
                Spacer()
                Text("No Recipies To Show")
                Spacer()
            }
            HStack {
                Spacer()
                Image(systemName: "chevron.down.2")
                Spacer()
            }
        }
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundStyle(Color.gray)
        .offset(y: 100)
    }
    
}


// MARK: Preview
#Preview {
    MainTabView()
}


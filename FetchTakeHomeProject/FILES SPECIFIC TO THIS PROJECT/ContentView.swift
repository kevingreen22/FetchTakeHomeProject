//
//  ContentView.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = HomeViewModel()
    @Environment(\.dismiss) var dismiss
    
    init() {}
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    if vm.recipes.isEmpty {
                        emptyRecipesText
                    } else {
                        ForEach(vm.recipes, id: \.uuid) { recipe in
                            HStack {
                                RecipeImageView(urlString: recipe.photoURLLarge, id: recipe.uuid)
                                    .frame(width: 44, height: 44)
                                VStack(alignment: .leading) {
                                    Text(recipe.name)
                                    Text(recipe.cuisine)
                                        .font(.caption)
                                        .opacity(0.7)
                                }
                            }.padding(.horizontal, 16)
                        }
                    }
                }
            }
            .task { await refresh() } // <-- starting point of data fetch.
            .refreshable { await refresh() }
        }
        .navigationTitle("Recipes")
        .background(Color.green)
        .alert(Text("Uh oh"), isPresented: $vm.showError) {
            Button("OK") { /* Handle acknowledgement here */ }
        } message: {
            Text("There was a problem getting yummy recipies to make. Try refreshing.")
        }
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
    
    fileprivate func refresh() async {
        await vm.loadRecipes()
    }
    
}


// MARK: Preview
#Preview {
    NavigationStack {
        ContentView().environmentObject(HomeViewModel())
    }
}

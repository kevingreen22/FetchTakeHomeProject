//
//  FetchTakeHomeProjectApp.swift
//  FetchTakeHomeProject
//
//  Created by Kevin Green on 2/1/25.
//

import SwiftUI

/*
 
 Hello Fetch Team! To change the url endpoint:
    - Use the APIURL struct static properites below and change the url passed in on line 23 of MainViewModel.swift
 
 */

/// The 3 endpoints provided.
struct APIURLs {
    static let recipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")

    static let malformedDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
    
    static let emptyDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
}


@main
struct FetchTakeHomeProjectApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

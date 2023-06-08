//
//  NewsApp.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

@main
struct NewsApp: App {
    @StateObject var topheadlinesViewModel = TopHeadlinesViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(topheadlinesViewModel)
                .environmentObject(homeViewModel)
        }
    }
}

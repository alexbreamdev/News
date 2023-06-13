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
    @StateObject var realm = RealmService(name: "articles")
    @StateObject var discoverViewModel = DiscoverViewModel()
    @AppStorage("isDark") var isDark: Bool = false
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(topheadlinesViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(realm)
                .environmentObject(discoverViewModel)
                .preferredColorScheme(isDark ? .dark : .light)
//            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        }
    }
}

//
//  ContentView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct MainView: View {
    @AppStorage("tab") private var selectedTab: Int = 1
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(1)
                TopHeadLinesView()
                    .tag(2)
                DiscoverView()
                    .tag(3)
                BookmarksView()
                    .tag(4)
                SettingsView()
                    .tag(5)
            }
            .tint(appTheme.tintColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TopHeadlinesViewModel())
            .environmentObject(HomeViewModel())
            .environmentObject(RealmService(name: "previewRealm"))
            .environmentObject(DiscoverViewModel())
    }
}

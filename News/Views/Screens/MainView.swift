//
//  ContentView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI
#warning("Attribute graph when switch between first and second tabs")
struct MainView: View {
    @AppStorage("tab") private var selectedTab: Int = 0
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
    }
}

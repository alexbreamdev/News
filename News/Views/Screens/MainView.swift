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
    
    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(1)
                TopHeadLinesView()
                    .tag(2)
                PlaceholderItemView(title: "Discover", systemIconName: "safari", selectedTab: $selectedTab)
                    .tag(3)
                PlaceholderItemView(title: "Bookmark", systemIconName: "bookmark", selectedTab: $selectedTab)
                    .tag(4)
                SettingsView()
                    .tag(5)
            }
            .tint(DefaultTheme.tintColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

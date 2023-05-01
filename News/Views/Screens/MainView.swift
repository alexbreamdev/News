//
//  ContentView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var topheadlinesViewModel = TopHeadlinesViewModel()
    @State private var selectedTab: Int = 1
    var body: some View {
            TabView(selection: $selectedTab) {
                TabItemView(title: "Home", systemIconName: "house", selectedTab: $selectedTab)
                TopHeadLinesView()
                    .tag(1)
                    .environmentObject(topheadlinesViewModel)
                    .tag(2)
                TabItemView(title: "Discover", systemIconName: "safari", selectedTab: $selectedTab)
                    .tag(2)
                TabItemView(title: "Bookmark", systemIconName: "bookmark", selectedTab: $selectedTab)
                    .tag(2)
                TabItemView(title: "Settings", systemIconName: "gearshape", selectedTab: $selectedTab)
                    .tag(3)
            }
            .tint(DefaultTheme.tintColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

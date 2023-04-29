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
                TopHeadLinesView()
                    .tag(1)
                    .environmentObject(topheadlinesViewModel)
                TabItemView(title: "Categories", systemIconName: "newspaper", selectedTab: $selectedTab)
                    .tag(2)
                TabItemView(title: "Media", systemIconName: "globe", selectedTab: $selectedTab)
                    .tag(2)
                TabItemView(title: "Search", systemIconName: "magnifyingglass", selectedTab: $selectedTab)
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

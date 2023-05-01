//
//  ContentView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var topheadlinesViewModel = TopHeadlinesViewModel()
    @AppStorage("tab") private var selectedTab: Int = 0
    
    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(1)
                
                TopHeadLinesView()
                    .environmentObject(topheadlinesViewModel)
                    .tag(2)
                PlaceholderItemView(title: "Discover", systemIconName: "safari", selectedTab: $selectedTab)
                    .tag(3)
                PlaceholderItemView(title: "Bookmark", systemIconName: "bookmark", selectedTab: $selectedTab)
                    .tag(4)
                PlaceholderItemView(title: "Settings", systemIconName: "gearshape", selectedTab: $selectedTab)
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

//
//  ContentView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 1
    var body: some View {
            TabView(selection: $selectedTab) {
                
                TopHeadLinesView()
                    .tag(1)
                TabItemView(title: "Categories", systemIconName: "newspaper", selectedTab: $selectedTab)
                    .tag(2)
                TabItemView(title: "Profile", systemIconName: "person.fill", selectedTab: $selectedTab)
                    .tag(3)
            }
            .tint(.purple)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

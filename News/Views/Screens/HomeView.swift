//
//  HomeView.swift
//  News
//
//  Created by Oleksii Leshchenko on 01.05.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home")
            .tabItem {
                Image(systemName: "house")
                Text("Home")
                    .multilineTextAlignment(.center)
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

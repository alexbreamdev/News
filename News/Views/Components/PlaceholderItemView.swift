//
//  TabItemView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct PlaceholderItemView: View {
    var title: String
    var systemIconName: String
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            VStack {
                Text (title + " tab")
                    .font(.largeTitle)
                    .foregroundColor(DefaultTheme.fontPrimary)
        
            }
            
        }
        .tabItem {
            Image(systemName: systemIconName)
            Text(title)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderItemView(title: "Hot", systemIconName: "flame", selectedTab: .constant(5))
    }
}

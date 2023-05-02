//
//  HomeView.swift
//  News
//
//  Created by Oleksii Leshchenko on 01.05.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Breaking News")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("See more")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(DefaultTheme.tintColor)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 120)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            Spacer()
        }
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

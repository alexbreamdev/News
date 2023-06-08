//
//  HomeView.swift
//  News
//
//  Created by Oleksii Leshchenko on 01.05.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @AppStorage("tab") private var selectedTab: Int = 1
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Top Headlines")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Button {
                            selectedTab = 2
                        } label: {
                            Text("See more")
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(DefaultTheme.tintColor)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(homeViewModel.articles) { article in
                                HomeCardView(article: article)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
            }
            
            if homeViewModel.viewState != .finished {
                RoundedRectangle(cornerRadius: 20)
                    .fill(DefaultTheme.backgroundSecondary)
                    .ignoresSafeArea()
                ProgressView()
            }
        }
        .task {
            await homeViewModel.getTenArticles()
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
            .environmentObject(HomeViewModel())
    }
}

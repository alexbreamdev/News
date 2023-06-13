//
//  HomeView.swift
//  News
//
//  Created by Oleksii Leshchenko on 01.05.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var realm: RealmService
    @AppStorage("tab") private var selectedTab: Int = 1
    @State private var path: [ArticleViewModel] = []
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack(spacing: 40) {
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
                        .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(homeViewModel.articles) { article in
                                    HomeCardView(article: article)
                                        .onTapGesture {
                                        }
                                        .onLongPressGesture {
                                            path.append(article)
                                        }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Bookmarks")
                                .font(.title2)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Button {
                                selectedTab = 4
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
                                ForEach(realm.artArray) { article in
                                    HomeCardView(article: article)
                                        .onTapGesture {
                                        }
                                        .onLongPressGesture {
                                            path.append(article)
                                        }
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
                        .tint(appTheme.tintColor)
                }
            }
            .navigationDestination(for: ArticleViewModel.self, destination: { article in
                ArticleWebView(urlString: article.url)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 5)
                }
            }
        }
        .tint(appTheme.tintColor)
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
            .environmentObject(RealmService(name: "previewRealm"))
    }
}

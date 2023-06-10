//
//  BookmarksView.swift
//  News
//
//  Created by Oleksii Leshchenko on 10.06.2023.
//

import SwiftUI
import RealmSwift

struct BookmarksView: View {
    @AppStorage("theme") var appTheme: Themes = .main
    @EnvironmentObject var realm: RealmService
    @State private var isLongPress: Bool = false
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 180)), GridItem(.adaptive(minimum: 180))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if realm.articlesArray.isEmpty {
                    VStack {
                        appTheme.backgroundPrimary.ignoresSafeArea()
                        Text("There is no bookmarks yet. Hurry up and add your favourite new")
                            .multilineTextAlignment(.center)
                    }
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(realm.artArray) { article in
                            NavigationLink(value:  article) {
                                HomeCardView(article: article, width: 180, height: 150)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: ArticleViewModel.self, destination: { article in
                ArticleWebView(urlString: article.url)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Bookmarks")
            .padding(15)
        }
        .tabItem {
            Image(systemName: "bookmark.fill")
            Text("Bookmarks")
                .multilineTextAlignment(.center)
        }
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
            .environmentObject(RealmService(name: "preview"))
    }
}

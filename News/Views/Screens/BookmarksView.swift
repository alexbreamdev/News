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
    @State private var removeAllDialog: Bool = false
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
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(realm.artArray) { article in
                            NavigationLink(value:  article) {
                                HomeCardView(article: article, width: 175, height: 130)
                                    .padding(.horizontal, 3)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .accessibilityAddTraits([.isHeader])
            .navigationDestination(for: ArticleViewModel.self, destination: { article in
                ArticleWebView(urlString: article.url)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Bookmarks")
            .padding(15)
            .accessibilityLabel("Bookmarks")
            .toolbar {
                
                ToolbarItemGroup {
                    Button {
                        removeAllDialog.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .font(.subheadline)
                    }
                    .tint(appTheme.tintColor)
                }
            }
        }
        .confirmationDialog("Are You Sure You Want To Remove All Articles", isPresented: $removeAllDialog, actions: {
            Button("Remove", role: .destructive) {
                realm.removeAll()
            }
        })
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
            .environmentObject(RealmService(name: "previewRealm"))
    }
}

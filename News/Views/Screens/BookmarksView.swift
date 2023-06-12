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
    @State private var isLongPressed: Bool = false
    @State private var tempId: String?
    @State private var path: [ArticleViewModel] = []
    @State private var offset: CGSize = .zero
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 175)), GridItem(.adaptive(minimum: 175))]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                if realm.articlesArray.isEmpty {
                    VStack {
                        appTheme.backgroundPrimary.ignoresSafeArea()
                        Text("There is no bookmarks yet. Hurry up and add your favourite articles")
                            .multilineTextAlignment(.center)
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(realm.artArray) { article in
                            HomeCardView(article: article, width: 175, height: 130)
                                .padding(.horizontal, 3)
                                .offset(tempId == article.id ? offset : .zero)
                                .onLongPressGesture {
                                    path.append(article)
                                }
                                .zIndex(tempId == article.id ? 100 : 0)
                                .overlay {
                                    ZStack {
                                        appTheme.tintColor
                                            .cornerRadius(10)
                                        Image(systemName: "trash.circle")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .shadow(radius: 5, x: 0, y: 4)
                                    }
                                    .padding(.horizontal, 3)
                                    .offset(tempId == article.id ? offset : .zero)
                                    .opacity(tempId == article.id && offset != .zero ? 1 : 0)
                                }
                                .gesture(
                                    DragGesture(minimumDistance: 50, coordinateSpace: .global)
                                        .onChanged { gesture in
                                            withAnimation {
                                                tempId = article.id
                                                offset = gesture.translation
                                            }
                                        }
                                        .onEnded {_ in
                                            withAnimation {
                                                if abs(offset.height) > 75 || abs(offset.width) > 75 {
                                                    realm.remove(article)
                                                }
                                                tempId = nil
                                                offset = .zero
                                            }
                                        }
                                )
                        }
                    }
                }
            }
            .accessibilityAddTraits([.isHeader])
            .navigationDestination(for: ArticleViewModel.self, destination: { article in
                ArticleWebView(urlString: article.url)
            })
            .navigationTitle("Bookmarks")
            .padding(15)
            .accessibilityLabel("Bookmarks")
            .toolbar {
                ToolbarItemGroup {
                    Menu {
                        Button {
                            removeAllDialog.toggle()
                        } label: {
                            Label("Delete All", systemImage: "trash")
                                .font(.subheadline)
                        }
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                            .labelStyle(.iconOnly)
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

//
//  DiscoverView.swift
//  News
//
//  Created by Oleksii Leshchenko on 13.06.2023.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var discoverViewModel: DiscoverViewModel
    @EnvironmentObject var realm: RealmService
    @AppStorage("theme") var appTheme: Themes = .main
    @State private var path: [ArticleViewModel] = []
    @State private var searchText: String = ""
    @State private var task: Task<Void, Never>?
    @Namespace var namespace
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(discoverViewModel.articles) { article in
                    NewsListRowView(article: article, isSelected: false, namespace: namespace)
                        .overlay(alignment: .topTrailing) {
                            bookmarkButton(article)
                                .allowsHitTesting(true)
                        }
                        .onTapGesture {}
                        .onLongPressGesture {
                            withAnimation {
                                path.append(article)
                            }
                        }
                }
                .listRowBackground(appTheme.backgroundPrimary)
                .listRowSeparator(.visible)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .searchable(text: $searchText, placement: .toolbar, prompt: Text("Apple, Google, etc."))
            .onSubmit(of: .search) {
                print(searchText)
                guard !searchText.isEmpty else { return }
                discoverViewModel.searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                Task {
                    await discoverViewModel.getAllArticles(discoverViewModel.sortBy)
                }
            }
            .onChange(of: discoverViewModel.sortBy, perform: { sortBy in
                Task {
                    print(sortBy.rawValue)
                    await discoverViewModel.getAllArticles(discoverViewModel.sortBy)
                }
            })
            .navigationDestination(for: ArticleViewModel.self, destination: { article in
                ArticleWebView(urlString: article.url)
            })
            .toolbar {
                ToolbarItemGroup {
                  sortMenu
                }
            }
            .navigationTitle("Discover")
            .alert(isPresented: $discoverViewModel.hasError, error: discoverViewModel.error) {
                alertButton
            }
        }
        .onDisappear {
            task?.cancel()
        }
        .tabItem {
            Image(systemName: "safari")
            Text("Discover")
                .multilineTextAlignment(.center)
        }
    }
}


extension DiscoverView {
    
    @ViewBuilder
    var alertButton: some View {
        Button {
            Task {
                await discoverViewModel.getAllArticles(discoverViewModel.sortBy)
            }
        } label: {
            Text("Retry")
        }
        
        Button(role: .cancel) {
            
        } label: {
            Text("Cancel")
        }
    }
    
    private func bookmarkButton(_ article: ArticleViewModel) -> some View {
        Image(systemName: realm.objectExist(article: article) ? "bookmark.fill" : "bookmark")
            .font(.body)
            .foregroundColor(appTheme.tintColor)
            .frame(width: 40)
            .padding(.trailing, 50)
            .onTapGesture {
                withAnimation {
                    if !realm.objectExist(article: article) {
                        realm.add(article)
                    } else {
                        realm.remove(article)
                    }
                }
            }
    }
    
    private var sortMenu: some View {
        Menu {
            Picker("Sort option", selection: $discoverViewModel.sortBy) {
                ForEach(SortBy.allCases) { sortOption in
                    Label(sortOption.labelText, systemImage: sortOption.icon)
                        .tag(sortOption)
                }
            }
        } label: {
            Label("Sort", systemImage: "line.3.horizontal.decrease")
                .labelStyle(.iconOnly)
        }
        .tint(appTheme.tintColor)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(DiscoverViewModel())
            .environmentObject(RealmService(name: "previewRealm"))
    }
}

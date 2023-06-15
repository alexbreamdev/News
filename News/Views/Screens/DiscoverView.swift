//
//  DiscoverView.swift
//  News
//
//  Created by Oleksii Leshchenko on 13.06.2023.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var discoverViewModel: DiscoverViewModel
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
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(DiscoverViewModel())
    }
}
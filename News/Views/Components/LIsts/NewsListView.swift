//
//  NewsListView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject private var topHeadlinesVM: TopHeadlinesViewModel
    @State private var task: Task<Void, Never>?
   
    var body: some View {
        List {
            ForEach(topHeadlinesVM.articles) { article in
                NewsListRowView(article: article)
                    .frame(height: 120)
                    .onTapGesture {
                            topHeadlinesVM.mainArticle = article
                            
                    }
                    .listRowBackground(topHeadlinesVM.mainArticle == article ? Color.secondary.opacity(0.3) : DefaultTheme.backgroundPrimary)
                    .task {
                        if topHeadlinesVM.hasReachedEnd(of: article) {
                            await topHeadlinesVM.getSetOfArticles()
                        }
                    }
                    
            }
            .listRowSeparator(.visible)
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .animation(.easeOut(duration: 2), value: topHeadlinesVM.mainArticle)
        }
        .scrollIndicators(.hidden)
        .listStyle(.inset)
        .task {
            await topHeadlinesVM.getAllArticles()
        }
        .onChange(of: topHeadlinesVM.category) { _ in
        
            task = Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                await topHeadlinesVM.getAllArticles()
            }
        }
        .onDisappear {
            
            task?.cancel()
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
            .environmentObject(TopHeadlinesViewModel())
    }
}

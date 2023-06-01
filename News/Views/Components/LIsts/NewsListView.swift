//
//  NewsListView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject private var topHeadlinesVM: TopHeadlinesViewModel
    @Namespace var namespace
    
    var body: some View {
        List {
            ForEach(topHeadlinesVM.articles) { article in
                NewsListRowView(article: article, isSelected: article == topHeadlinesVM.mainArticle, namespace: namespace)
                    .frame(height: 120)
                    .onTapGesture {
                        withAnimation {
                            topHeadlinesVM.mainArticle = article
                        }
                    }
                    .listRowBackground(DefaultTheme.backgroundPrimary)
                    .task {
                        if topHeadlinesVM.hasReachedEnd(of: article) {
                            await topHeadlinesVM.getSetOfArticles()
                        }
                    }
                    
            }
            .listRowSeparator(.visible)
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

        }
        .scrollIndicators(.hidden)
        .listStyle(.inset)
      
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
            .environmentObject(TopHeadlinesViewModel())

    }
}

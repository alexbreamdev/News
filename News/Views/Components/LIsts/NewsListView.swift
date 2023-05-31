//
//  NewsListView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject var topHeadlinesVM: TopHeadlinesViewModel
   
    var body: some View {
        List {
            ForEach(topHeadlinesVM.articles) { article in
                NewsListRowView(article: article)
                    .frame(height: 120)
                    .onTapGesture {
                            topHeadlinesVM.mainArticle = article
                            
                    }
                    .listRowBackground(topHeadlinesVM.mainArticle == article ? Color.secondary.opacity(0.3) : DefaultTheme.backgroundPrimary)
                    
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

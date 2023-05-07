//
//  TopHeadLinesView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct TopHeadLinesView: View {
    @EnvironmentObject var topHeadlinesViewModel: TopHeadlinesViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                MainCardView(article: topHeadlinesViewModel.mainArticle)
                
                CategoryListRoulette()
                
                NewsListView()
                
            }
        }
        .tabItem {
            Image(systemName: "flame")
            Text("Top Headlines")
                .multilineTextAlignment(.center)
        }
    }
}

struct TopHeadLinesView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadLinesView()
            .environmentObject(TopHeadlinesViewModel())
    }
}

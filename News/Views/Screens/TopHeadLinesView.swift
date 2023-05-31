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
                
                CategoryListRoulette(selectedCategory: $topHeadlinesViewModel.category)
                
                NewsListView()
                
            }
        }
        .alert(isPresented: $topHeadlinesViewModel.hasError, error: topHeadlinesViewModel.error) {
            alertButton
        }
        .tabItem {
            Image(systemName: "flame")
            Text("Top Headlines")
                .multilineTextAlignment(.center)
        }
    }
}

extension TopHeadLinesView {
    
    @ViewBuilder
    var alertButton: some View {
        Button {
            Task {
                await topHeadlinesViewModel.getAllArticles()
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

struct TopHeadLinesView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadLinesView()
            .environmentObject(TopHeadlinesViewModel())
    }
}

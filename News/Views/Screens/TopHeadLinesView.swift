//
//  TopHeadLinesView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct TopHeadLinesView: View {
    @EnvironmentObject var topHeadlinesViewModel: TopHeadlinesViewModel
    @State private var task: Task<Void, Never>?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 15) {
                    NavigationLink {
                        ArticleWebView(urlString: topHeadlinesViewModel.mainArticle.url)
                    } label: {
                        MainCardView(article: topHeadlinesViewModel.mainArticle)
                    }
                    
                    CategoryListRoulette(selectedCategory: $topHeadlinesViewModel.category)
                    
                    NewsListView()
                }
                
                if topHeadlinesViewModel.isLoading {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(DefaultTheme.backgroundSecondary)
                        .ignoresSafeArea()
                    ProgressView()
                }
            }
        }
        .alert(isPresented: $topHeadlinesViewModel.hasError, error: topHeadlinesViewModel.error) {
            alertButton
        }
        .task {
            await topHeadlinesViewModel.getAllArticles(false)
        }
        .onChange(of: topHeadlinesViewModel.category) { _ in
            task = Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                await topHeadlinesViewModel.getAllArticles(false)
            }
        }
        .onDisappear {
            task?.cancel()
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
            .previewDisplayName("Full Screen Top Headlines")
    }
}

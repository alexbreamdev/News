//
//  HomeViewModel.swift
//  News
//
//  Created by Oleksii Leshchenko on 08.06.2023.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var articles: [ArticleViewModel] = []
    
    @Published var error: NetworkingService.NetworkingError?
    @Published var hasError: Bool = false
    @Published var viewState: ViewState?
    
    func getTenArticles() async {
        reset()

        viewState = .loading

        defer {
            viewState = .finished
        }
        
        do {
            let result = try await NetworkingService.shared.request(Endpoint.topHeadlines(page: 1, pageSize: 10, category: .all), type: TopHeadlinesResult.self)

            self.articles = Array(result.articles.compactMap { article -> ArticleViewModel? in
                return ArticleViewModel(article)
            }[..<10])
            
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}

extension HomeViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
    
    func reset() {
        if viewState == .finished {
            articles.removeAll()
            viewState = nil
        }
    }
}

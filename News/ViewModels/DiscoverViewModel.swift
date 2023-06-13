//
//  DiscoverViewModel.swift
//  News
//
//  Created by Oleksii Leshchenko on 13.06.2023.
//

import SwiftUI
import Combine

#warning("Work in progress")
@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var articles: [ArticleViewModel] = []
    @Published var error: NetworkingService.NetworkingError?
    @Published var hasError: Bool = false
    @Published var viewState: ViewState?
    @Published var searchText: String = ""
    @Published var sortBy: SortBy = .publishedAt
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    let dataSevice = MockService.shared
    var cancellables = Set<AnyCancellable>()
    
    private var page: Int = 1
    private var pageSize: Int? = 20
    private var totalResults: Int = 0
    private var totalPages: Int? {
        if totalResults > 0, let pageSize = pageSize {
            return totalResults / pageSize
        } else {
            return nil
        }
    }
    
    func getAllArticles(_ isDebug: Bool = false) async {
        if isDebug {
            getAllArticlesMock()
        } else {
           await getAllArticles()
        }
    }
    
    // initial api call
    func getAllArticles() async {
        reset()
        
        guard !searchText.isEmpty else { return }
        
        viewState = .loading

        defer {
            viewState = .finished
        }
        
        do {
            let result = try await NetworkingService.shared.request(Endpoint.everything(page: page, pageSize: pageSize, searchText: searchText, language: "en", sortBy: sortBy), type: EverythingResults.self)
            totalResults = result.totalResults
            self.articles = result.articles.compactMap { article -> ArticleViewModel? in
                return ArticleViewModel(article)
            }
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // next page api call
    // pagination doesn't work
    func getSetOfArticles() async {
        guard totalPages != nil, page != totalPages else {
            return
        }
        
        viewState = .fetching
        
        defer {
            viewState = .finished
        }
        
        page += 1
        
        do {
            // request using endpoint and user
            let result = try await NetworkingService.shared.request(Endpoint.everything(page: page, pageSize: pageSize, searchText: searchText, language: "en", sortBy: sortBy), type: EverythingResults.self)
            totalResults = result.totalResults
            self.articles += result.articles.compactMap { article -> ArticleViewModel? in
                return ArticleViewModel(article)
            }
           
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // mock function
    func getAllArticlesMock() {
        viewState = .loading
        dataSevice.$articlesUSA
            .map { article -> [ArticleViewModel] in
                article
                    .compactMap {
                        ArticleViewModel($0)
                    }
            }
            .delay(for: 3, scheduler: RunLoop.main)
            .sink { [weak self] returnedArticles in
                if let self = self {
                    self.articles = returnedArticles
            
                    self.viewState = .finished
                }
            }
            .store(in: &cancellables)
    }
    
    // Check if the passed article id equals last article id
    // in initially downloaded articles list
    // helps to determine if next batch is of API calls needed
    func hasReachedEnd(of article: ArticleViewModel) -> Bool {
        return articles.last?.id == article.id
    }
}

// MARK: - State of View
extension DiscoverViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension DiscoverViewModel {
    func reset() {
        if viewState == .finished {
            articles.removeAll()
            page = 1
            totalResults = 0
            viewState = nil
        }
    }
}

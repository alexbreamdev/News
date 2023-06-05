//
//  TopHeadlinesViewModel.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import Foundation
import Combine

@MainActor
final class TopHeadlinesViewModel: ObservableObject {
    @Published var articles: [ArticleViewModel] = []
    @Published var mainArticle: ArticleViewModel = .placeholderArticle
    @Published var error: NetworkingService.NetworkingError?
    @Published var hasError: Bool = false
    @Published var viewState: ViewState?
    @Published var category: Category = .all
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    let dataSevice = MockService.shared
    var cancellables = Set<AnyCancellable>()
    
    private var page: Int = 1
    private var pageSize: Int? = 10
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

        viewState = .loading

        defer {
            viewState = .finished
        }
        
        do {
            let result = try await NetworkingService.shared.request(Endpoint.topHeadlines(page: page, pageSize: pageSize, category: category), type: TopHeadlinesResult.self)
            totalResults = result.totalResults
            self.articles = result.articles.compactMap { article -> ArticleViewModel? in
                return ArticleViewModel(article)
            }
            if self.articles.count > 0 {
                self.mainArticle = self.articles.first!
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
            let result = try await NetworkingService.shared.request(Endpoint.topHeadlines(page: page, pageSize: pageSize, category: category), type: TopHeadlinesResult.self)
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
                    if self.articles.count > 0 {
                        mainArticle = self.articles[0]
                    }
                    self.viewState = .finished
                }
            }
            .store(in: &cancellables)
    }
    
    func hasReachedEnd(of article: ArticleViewModel) -> Bool {
        return articles.last?.id == article.id
    }
}

struct ArticleViewModel: Identifiable {
    let id: String
    let title: String
    let url: String
    let urlToImage: String
    let sourceName: String
    let description: String?
    let content: String?
    private let publishedAt: Date
    
    var publishedDate: String {
        if Calendar.current.isDate(publishedAt, equalTo: Date.now, toGranularity: .day) {
            return "Today, \(publishedAt.formatted(date: .omitted, time: .shortened))"
        } else {
            return publishedAt.formattedDate()
        }
    }
    
    init() {
        self.id = "id"
        self.title = "Placeholder"
        self.url = ""
        self.urlToImage = ""
        self.sourceName = "CNN"
        self.description = "Description here"
        self.content = "Some content"
        self.publishedAt = Date.now
    }
    
    init?(_ article: Article) {
        self.id = article.id
        if article.title == nil { return nil }
        self.title = article.title!
        self.url = article.url
        self.description = article.description
        self.sourceName = article.source.name
        self.urlToImage = article.urlToImage ?? ""
        self.content = article.content ?? ""
        self.publishedAt = article.publishedAt
    }
    
    static var placeholderArticle: ArticleViewModel {
        return ArticleViewModel()
    }
}

extension ArticleViewModel: Equatable {
    
}

// MARK: - State of VIew
extension TopHeadlinesViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension TopHeadlinesViewModel {
    func reset() {
        if viewState == .finished {
            articles.removeAll()
            page = 1
            totalResults = 0
            viewState = nil
        }
    }
}

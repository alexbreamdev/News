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
    
    let dataSevice = MockService.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getAllArticles()
    }
    
    func getAllArticles() {
        dataSevice.$articlesUSA
            .map { article -> [ArticleViewModel] in
                article
                    .compactMap {
                        ArticleViewModel($0)
                    }
            }
            .sink { [weak self] returnedArticles in
                if let self = self {
                    self.articles = returnedArticles
                    if self.articles.count > 0 {
                        mainArticle = self.articles[0]
                    }
                }
            }
            .store(in: &cancellables)
    }
}

struct ArticleViewModel: Identifiable {
    let id: String
    let title: String
    let url: String
    let urlToImage: String
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
        self.publishedAt = Date.now
    }
    
    init?(_ article: Article) {
        self.id = article.id
        if article.title == nil { return nil }
        self.title = article.title!
        self.url = article.url
        self.urlToImage = article.urlToImage ?? ""
        self.publishedAt = article.publishedAt
    }
    
    static var placeholderArticle: ArticleViewModel {
        return ArticleViewModel()
    }
}

extension ArticleViewModel: Equatable {
    
}

//
//  ArticleViewModel.swift
//  News
//
//  Created by Oleksii Leshchenko on 10.06.2023.
//

import Foundation
import RealmSwift
// MARK: - ViewModel for Article
struct ArticleViewModel: Identifiable, Hashable {
    let id: String
    let title: String
    let url: String
    let urlToImage: String
    let sourceName: String
    let description: String?
    let content: String?
    let publishedAt: Date
    
    var publishedDateString: String {
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
    
    init(_ article: ArticleRealm) {
        self.id = article.id
        self.title = article.title
        self.url = article.url
        self.description = article.description
        self.sourceName = article.sourceName
        self.urlToImage = article.urlToImage
        self.content = article.content ?? ""
        self.publishedAt = article.publishedAt
    }
    
    static var placeholderArticle: ArticleViewModel {
        return ArticleViewModel()
    }
}

extension ArticleViewModel: Equatable {
    
}

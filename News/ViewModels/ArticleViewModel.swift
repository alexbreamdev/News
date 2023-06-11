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
        self.title = "The Israeli plan to fit a fusion reactor into a container - BBC"
        self.url = "https://www.bbc.com/news/business-65123116"
        self.urlToImage = "https://ichef.bbci.co.uk/news/1024/branded_news/DB3B/production/_129232165_image00004.jpg"
        self.sourceName = "BBC News"
        self.description = "Israel's NT-Tao wants to build a compact fusion reactor and has won investment from Honda."
        self.content = "From the outside it looks like an ordinary warehouse. But inside this unassuming building, in Hod Hasharon central Israel, is one of the most ambitious energy projects in the Middle East,\r\nResearcher… [+6174 chars]"
        self.publishedAt = Date.now
        self.id = url + title + "\(publishedAt)"
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

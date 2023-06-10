//
//  ArticleRealm.swift
//  News
//
//  Created by Oleksii Leshchenko on 10.06.2023.
//

import Foundation
import RealmSwift

class ArticleRealm: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var sourceName: String
    @Persisted var title: String
    @Persisted var desc: String?
    @Persisted var url: String
    @Persisted var urlToImage: String
    @Persisted var publishedAt: Date
    @Persisted var content: String?
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init(article: ArticleViewModel) {
        self.init()
        self.id = article.id
        self.sourceName = article.sourceName
        self.title = article.title
        self.desc = article.description
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.publishedAt = article.publishedAt
        self.content = article.content
    }
}

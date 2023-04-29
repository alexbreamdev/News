//
//  MockService.swift
//  MyAppleNews
//
//  Created by Oleksii Leshchenko on 28.03.2023.
//

import Foundation


final class MockService {
    static let shared = MockService()
    var article: Article {
        return downloadTopHeadlineArticles()[0]
    }

    @Published var articlesUSA: [Article] = []
    
    private init() {
        articlesUSA = downloadTopHeadlineArticles()
    }
    
    func downloadTopHeadlineArticles() -> [Article] {
        let file = "topheadlinesusa.json"
        do {
            return try Bundle.main.decode(TopHeadlinesResult.self, from: file, dateDecodingStrategy: .iso8601).articles
        } catch {
            print(error)
        }
        return []
    }
}

//
//  TopHeadlineResults.swift
//  MyAppleNews
//
//  Created by Oleksii Leshchenko on 28.03.2023.
//

import Foundation

// MARK: - TopHeadlinesResult
struct TopHeadlinesResult: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author, title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

extension Article: Identifiable {
    var id: String {
        return (source.id ?? "") + source.name + ISO8601DateFormatter().string(from: publishedAt)
    }
    
    var publishedDate: String {
        if Calendar.current.isDate(publishedAt, equalTo: Date.now, toGranularity: .day) {
            return "Today, \(publishedAt.formatted(date: .omitted, time: .shortened))"
        } else {
            return publishedAt.formattedDate()
        }
    }
}


extension Article: Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

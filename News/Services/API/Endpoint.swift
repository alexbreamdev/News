//
//  Endpoint.swift
//  ThePeople
//
//  Created by Oleksii Leshchenko on 26.05.2023.
//

import Foundation

//https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY
// MARK: - Way to interact with API endpoints, using enum, query
enum Endpoint {
    // to topHeadlinesview // page is using query parameter to make pagination
    case topHeadlines(page: Int?, pageSize: Int?, category: Category)
    case everything(page: Int?, pageSize: Int?, searchText: String, language: String, sortBy: SortBy)

}

// MARK: - Method type GET POST for endpoint
extension Endpoint {
    enum MethodType {
        case GET
        // send data with post method
        case POST(data: Data?)
    }
}

// MARK: - Paths
extension Endpoint {
    // base url
    var host: String { "newsapi.org" }
    
    // path to different endpoints
    var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .everything:
            return "/v2/everything"
  
        }
    }
    
    // method type from enum
    var methodType: MethodType {
        switch self {
        case .topHeadlines:
            return .GET
        case .everything:
            return .GET
        }
    }
    
    
    // query items
    var queryItems: [String: String]? {
        switch self {
        case .topHeadlines(let page, let pageSize, let category):
            var topHeadlinesQueryItems = ["apiKey": ApiKey.freeKey.rawValue, "country" : "us"]
            if let page = page, let pageSize = pageSize {
                topHeadlinesQueryItems.updateValue("\(page)", forKey: "page")
                topHeadlinesQueryItems.updateValue("\(pageSize)", forKey: "pageSize")
            }
            
            if category != .all {
                topHeadlinesQueryItems.updateValue(category.rawValue, forKey: "category")
            }
            
            return topHeadlinesQueryItems
            
        case .everything(let page, let pageSize, let searchText, let language, let sortBy):
            var everythingQueryItems = ["apiKey": ApiKey.freeKey.rawValue, "q" : searchText.lowercased(), "language" : language, "sortBy" : sortBy.rawValue]
            if let page = page, let pageSize = pageSize {
                everythingQueryItems.updateValue("\(page)", forKey: "page")
                everythingQueryItems.updateValue("\(pageSize)", forKey: "pageSize")
            }
            return everythingQueryItems

        }
    }
}

// MARK: - URL creation
extension Endpoint {
    
    var url: URL? {
        // create URLComponents object to create URL conditionally
        var urlComponents = URLComponents()
        // request schema http or https
        urlComponents.scheme = "https"
        // adding base url address to components
        urlComponents.host = host
        // adding path to components
        urlComponents.path = path
        
        
        let requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        urlComponents.queryItems = requestQueryItems
        return urlComponents.url
    }
}

// MARK: - Sorting endpoint
enum SortBy: String, CaseIterable, Identifiable {
    case relevancy
    case popularity
    case publishedAt
    
    var icon: String {
        switch self {
        case .relevancy:
            return "doc.text.magnifyingglass"
        case .popularity:
            return "person.3"
        case .publishedAt:
            return "clock"
        }
    }
    
    var labelText: String {
        switch self {
        case .relevancy:
            return "Relevancy"
        case .popularity:
            return "Popularity"
        case .publishedAt:
            return "Date Published"
        }
    }
    
    var id: Self {
        self
    }
}

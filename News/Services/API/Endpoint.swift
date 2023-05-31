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
    // to PeopleView // page is using query parameter to make pagination
    case topHeadlines(page: Int?, pageSize: Int?)
    
    // to DetailView
    case detail(id: Int)

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
        case let .detail(id):
            return ""
  
        }
    }
    
    // method type from enum
    var methodType: MethodType {
        switch self {
        case .topHeadlines:
            return .GET
        case .detail:
            return .GET
        }
    }
    
    
    // query items
    var queryItems: [String: String]? {
        switch self {
        case .topHeadlines(let page, let pageSize):
            if let page = page, let pageSize = pageSize {
                return ["page": "\(page)", "pageSize": "\(pageSize)", "country":"us", "apiKey": ApiKey.freeKey.rawValue]
            } else {
                return ["apiKey": ApiKey.freeKey.rawValue]
            }
        default:
            return nil
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
        // adding path to components (people, detail(id: Int, create)
        urlComponents.path = path
        
        
        var requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        #if DEBUG
        // query parameters (items) such as delay=3, pages
        requestQueryItems?.append(URLQueryItem(name: "delay", value: "1"))
        #endif
        urlComponents.queryItems = requestQueryItems
        return urlComponents.url
    }
}

//
//  Categories.swift
//  News
//
//  Created by Oleksii Leshchenko on 30.04.2023.
//

import Foundation

/*
 The category you want to get headlines for. Possible options: business
 entertainment
 general
 health
 science
 sports
 technology.
 Note: you can't mix this param with the sources param.
 */

enum Category: String, CaseIterable {
    case all
    case general
    case technology
    case entertainment
    case sports
    case health
    case science
    
    var categoryLabel: String {
        switch self {
        case .all:
            return "All"
        case .general:
            return "📰 Popular"
        case .technology:
            return "💻 Tech"
        case .entertainment:
            return "🎉 Entertainment"
        case .sports:
            return "⚽️ Sports"
        case .health:
            return "🩺 Health"
        case .science:
            return "🔬 Science"
        }
    }
}

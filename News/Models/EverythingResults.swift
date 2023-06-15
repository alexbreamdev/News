//
//  EverythingResults.swift
//  News
//
//  Created by Oleksii Leshchenko on 13.06.2023.
//

import Foundation

// MARK: - Result on /everything endpoint call
struct EverythingResults: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

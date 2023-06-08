//
//  Date+Extension.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import Foundation

// MARK: - Formatt date with locale
extension Date {
    func formattedDate(locale: String = "en_us") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: self)
    }
}

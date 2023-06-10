//
//  Theme.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI
import UIKit

protocol MyTheme {
    static var backgroundPrimary: Color { get set }
    static var backgroundSecondary: Color { get set }
    static var fontPrimary: Color { get set }
    static var fontSecondary: Color { get set }
    static var tintColor: Color { get set }
}

protocol ThemeSize {
    static var cornerRadius: CGFloat { get set }
    static var lineWidth: CGFloat { get set}
    static var paddingSmall: CGFloat { get set }
    static var paddingMedium: CGFloat { get set }
    static var spacing: CGFloat { get set }
}
#warning("implement fonts, sizes and etc.")
struct DefaultTheme: MyTheme {
    // MARK: - Colors
    static var backgroundPrimary: Color = Color(uiColor: .systemBackground)
    static var backgroundSecondary: Color = Color(uiColor: .secondarySystemBackground)
    static var fontPrimary: Color = Color.primary
    static var fontSecondary: Color = Color.secondary
    static var tintColor: Color = Color(uiColor: .systemOrange)
    
}

enum Themes: String, Codable, CaseIterable {
    case main
    
    
    var backgroundPrimary: Color {
        switch self {
        case .main:
            return Color(uiColor: .systemBackground)
        }
    }
    
    var backgroundSecondary: Color {
        switch self {
        case .main:
            return Color(uiColor: .secondarySystemBackground)
        }
    }
    
    var fontPrimary: Color {
        switch self {
        case .main:
            return Color.primary
        }
    }
    
    var fontSecondary: Color {
        switch self {
        case .main:
            return Color.secondary
        }
    }
    
    var tintColor: Color {
        switch self {
        case .main:
            return Color(uiColor: .systemOrange)
        }
    }
}

//
//  CategoryListRoulette.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct CategoryListRoulette: View {
    @State private var selectedCategory: Category = .all
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Category.allCases, id: \.rawValue) { category in
                    CategoryView(category: category, selected: selectedCategory == category)
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryView: View {
    let category: Category
    let selected: Bool
    
    var body: some View {
        Text(category.categoryLabel)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding()
            .background(selected ? DefaultTheme.tintColor.opacity(0.7) : DefaultTheme.backgroundSecondary)
            .cornerRadius(20)
    }
}

struct CategoryListRoulette_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListRoulette()
       
    }
}

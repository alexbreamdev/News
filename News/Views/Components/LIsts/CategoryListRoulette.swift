//
//  CategoryListRoulette.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct CategoryListRoulette: View {
    @Binding var selectedCategory: Category
    @Namespace var namespace
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Category.allCases, id: \.rawValue) { category in
                    CategoryView(category: category, selected: selectedCategory == category, namespace: namespace)
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = category
                                
                            }
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
    let namespace: Namespace.ID
    
    var body: some View {
        Text(category.categoryLabel.uppercased())
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 7)
            .padding(.horizontal)
            .background {
                if selected {
                    Capsule()
                        .fill(DefaultTheme.tintColor.opacity(0.7))
                        .matchedGeometryEffect(id: "Selected", in: namespace, isSource: selected)
                } else {
                    Capsule()
                        .stroke(DefaultTheme.tintColor, lineWidth: 1)
                }
            }
            .padding(.vertical, 1)
    }
}

struct CategoryListRoulette_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListRoulette(selectedCategory: .constant(.all))
       
    }
}

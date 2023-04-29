//
//  CategoryListRoulette.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct CategoryListRoulette: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 44)
                        .overlay(alignment: .center) {
                            Text("category name")
                                .foregroundColor(.white)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryListRoulette_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListRoulette()
       
    }
}

//
//  NewsListRowView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI
#warning("Row namespace ID bug")
struct NewsListRowView: View {
    let article: ArticleViewModel
    @State private var menuPressed: Bool = false
    let isSelected: Bool
    let namespace: Namespace.ID
    
    var body: some View {
        HStack(alignment: .top) {
            
            AsyncImageView(urlString: article.urlToImage)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(5)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("\(article.sourceName)")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                        .background(DefaultTheme.tintColor.opacity(0.3))
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 5)
                        )
                    Text(article.publishedDate)
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Text(article.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 5)
//            Spacer(minLength: 20)
         
        }
        .overlay {
            if isSelected {
                Rectangle()
                    .foregroundStyle(LinearGradient(colors: [DefaultTheme.tintColor.opacity(0.2), DefaultTheme.tintColor.opacity(0)], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
//                    .matchedGeometryEffect(id: "row", in: namespace)
                    .allowsHitTesting(false)
            }
        }
    }
}

struct NewsListRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NewsListRowView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!, isSelected: true, namespace: namespace)
    }
}

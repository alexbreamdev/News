//
//  HomeCardView.swift
//  News
//
//  Created by Oleksii Leshchenko on 07.06.2023.
//

import SwiftUI

struct HomeCardView: View {
    let article: ArticleViewModel
    
    var body: some View {
        AsyncImageView(urlString: article.urlToImage)
            .scaledToFill()
            .frame(width: 250, height: 150)
            .overlay(alignment: .bottom) {
                VStack {
                    Text(article.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(4)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity)
                .background(DefaultTheme.backgroundPrimary)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                thinBorderOverlay
            }
    }
    
    private var thinBorderOverlay: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(DefaultTheme.backgroundSecondary)
            .shadow(color: DefaultTheme.backgroundSecondary, radius: 4, x: 0, y: 4)
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
    }
}

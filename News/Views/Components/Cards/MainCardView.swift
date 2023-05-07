//
//  MainCardView.swift
//  News
//
//  Created by Oleksii Leshchenko on 07.05.2023.
//

import SwiftUI

struct MainCardView: View {
    let article: ArticleViewModel
    
    var body: some View {
        AsyncImageView(urlString: article.urlToImage)
            .frame(width: UIScreen.main.bounds.width - 20, height: 250)
            .clipped()
            .cornerRadius(10)
            .overlay(alignment: .bottom) {
                Text(article.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(DefaultTheme.backgroundPrimary)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(DefaultTheme.backgroundSecondary)
            }
            
            
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCardView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
    }
}

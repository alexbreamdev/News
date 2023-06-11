//
//  HomeCardView.swift
//  News
//
//  Created by Oleksii Leshchenko on 07.06.2023.
//

import SwiftUI

struct HomeCardView: View {
    let article: ArticleViewModel
    var width: CGFloat = 250
    var height: CGFloat = 150
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some View {
        AsyncImageView(urlString: article.urlToImage)
            .scaledToFill()
            .frame(width: width, height: height)
            .overlay(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(appTheme.fontPrimary)
                        .multilineTextAlignment(.leading)
                        .padding(4)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity)
                .background(appTheme.backgroundPrimary)
            }
            .overlay(alignment: .top, content: {
                HStack {
                    Text(article.sourceName)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(appTheme.fontPrimary)
                        .lineLimit(1)
                        .padding(2)
                        .padding(.horizontal, 2)
                        .background(appTheme.tintColor)
                        .cornerRadius(5)
                    Spacer(minLength: 50)
                    
                    Text(article.publishedDateString)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(appTheme.fontPrimary)
                        .lineLimit(1)
                        .padding(2)
                        .padding(.horizontal, 2)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 5))
                }
            })
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                thinBorderOverlay
            }
    }
    
    private var thinBorderOverlay: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(appTheme.backgroundSecondary)
            .shadow(color: appTheme.backgroundSecondary, radius: 4, x: 0, y: 4)
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
    }
}

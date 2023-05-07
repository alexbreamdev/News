//
//  NewsListRowView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct NewsListRowView: View {
    let article: ArticleViewModel
    @State private var menuPressed: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            
            AsyncImageView(urlString: article.urlToImage)
                .frame(width: 100, height: 100)
                .cornerRadius(5)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("\("📰 CNN")")
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
                       
                }
                
                Text(article.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 5)
            Spacer(minLength: 30)
            
            Rectangle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.clear)
                .allowsHitTesting(false)
                .overlay(alignment: .trailing) {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(menuPressed ? Color.yellow : Color.primary)
                            .frame(width: 30, height: 30)
                            .rotationEffect(.degrees(90))
                            .allowsHitTesting(true)
                            .onTapGesture {
                                withAnimation {
                                    menuPressed.toggle()
                                    
                                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in menuPressed.toggle()}
                                }
                                print("Pressed button")
                            }
                }
         
        }
    }
}

struct NewsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListRowView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
    }
}
